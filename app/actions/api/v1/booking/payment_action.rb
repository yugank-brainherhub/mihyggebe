# frozen_string_literal: true

module API
  module V1
    class Booking::PaymentAction < Booking::BaseAction
      attr_accessor :charge, :new_customer

      def perform
        booking = record
        begin
          raise unless booking.draft?
          create_customer if current_user.stripeID.blank?
          use_existing_card if permitted_params[:type] == 'card'
          add_new_source if current_user.stripeID.present? && permitted_params[:type] == 'token'

          amount = calculate_amount(booking)
          @charge = create_stripe_charge(amount.to_i)
          booking_status = @charge.status
          booking.create_payment(chargeId: charge.id,
                                 amount: amount,
                                 status: status,
                                 description: "charge for #{current_user.full_name}")
          booking.pending!
          transfer_duration = Rails.env.production? ? 18.days : 40.minutes
          TransferJob.set(wait: transfer_duration).perform_later(booking.id)
          BookingMailer.with(user: current_user).send_payment_mail(booking, booking_status).deliver_now
          ::Room.reset_blocked_beds(booking.beds.ids.collect(&:to_s))
          @success = true
        rescue StandardError => e
          @success = false
          fail_with_error(422, '', error: e.message)
        end
      end

      def calculate_amount(booking)
        beds = booking.beds
        no_of_beds = beds.count
        no_of_days = calculate_no_of_days(booking)
        price_per_bed = booking.price_per_bed
        tax_percent_per_bed = TAXES.fetch(booking.care.state.upcase.to_sym)
        tax_per_bed = calculate_percent(price_per_bed, tax_percent_per_bed)
        total_amount = (price_per_bed + tax_per_bed) * no_of_beds * no_of_days
        total_amount.round(2) * 100
      end

      def calculate_no_of_days(booking)
        checkin = booking.checkin
        checkout = booking.checkout
        days = (checkout.to_date - checkin.to_date).to_i
        days.zero? ? 1 : days
      end

      def calculate_percent(value, percent)
        ans = (value * percent).to_f / 100
        return ans.round if ans < ans.round

        ans.round(2)
      end

      def status
        charge.status == 'succeeded' ? 'paid' : 'rejected'
      end

      def create_stripe_charge(amount)
        Stripe::Charge.create(
          amount: amount,
          currency: 'usd',
          customer: current_user.reload.stripeID,
          description: "charge for #{current_user.full_name}"
        )
      end

      def data
        charge
      end

      def authorize!
        true
      end

      def use_existing_card
        Stripe::Customer.update(
          current_user.stripeID,
          default_source: permitted_params[:source],
          invoice_settings: { default_payment_method: permitted_params[:source] } # existing card id,
        )
      end

      def create_customer
        customer = Stripe::Customer.create(
          description: "Customer for #{current_user.email}",
          email: current_user.email,
          source: permitted_params[:source]
        )
        @new_customer = true
        current_user.update_columns(stripeID: customer.id)
      end

      def add_new_source
        return if new_customer
        Stripe::Customer.create_source(
          current_user.stripeID,
          source: permitted_params[:source] # card token
        )
      end

      def permitted_params
        params.require(:booking).permit(:source, :type)
      end
    end
  end
end
