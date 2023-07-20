# frozen_string_literal: true

module API
  module V1
    class Booking::UpdateAction < Booking::BaseAction
      attr_accessor :refund

      CANCEL_DURATION_FULL = Rails.env.production? ? 72.hours : 15.minutes
      CANCEL_DURATION_HALF = Rails.env.production? ? 15.days : 30.minutes
      def data
        API::V1::BookingSerializer.new(record)
      end

      def perform
        if permitted_params[:status] == 'cancelled' && !cancelled_before_checkin?
          return fail_with_error(422, :user, I18n.t('booking.cancel_not_allowed'))
        end
        @success = save_record!
      end

      def save_record!
        if record.update(refunds_param? ? permitted_params.merge(cancelled_at: Time.current) : permitted_params)
          if permitted_params[:doc_received]
            BookingMailer.doc_update(record).deliver_now
          elsif permitted_params[:status].present?
            begin
              initiate_refund if refund_criteria_met?
            rescue StandardError => e
              @success = false
              Bugsnag.notify(e)
              return fail_with_error(422, '', error: e.message)
            end
            BookingMailer.status_update(record).deliver_now
          end
          return true
        end

        fail_with_error(422, self.class.record_type, record.errors)
      end

      def initiate_refund
        payment = record.payment
        return if payment.nil? || refund_not_applicable?(payment)

        @refund = create_refund(payment)
        Refund.create!(amount: refund.amount,
                       chargeId: refund.charge,
                       refundId: refund.id,
                       description: "refund for #{current_user.full_name}",
                       status: status,
                       booking: record,
                       payment: payment)
      end

      def cancelled_before_checkin?
        Date.today < record.checkin.to_date
      end

      def refunds_param?
        permitted_params[:status] == 'cancelled' || permitted_params[:status] == 'rejected'
      end

      def refund_criteria_met?
        record.cancelled? || record.rejected?
      end

      def status
        refund.status == 'succeeded' ? 'success' : 'failed'
      end

      def create_refund(payment)
        refund_type = check_refund_type(payment)
        create_stripe_refund(refund_type, payment.amount, payment.chargeId)
      end

      def create_stripe_refund(refund_type, amount, charge_id)
        amount_to_refund = if refund_type == :full
                             amount.to_i
                           else
                             (amount / 2).ceil
                           end

        Stripe::Refund.create(
          charge: charge_id,
          amount: amount_to_refund
        )
      end

      def check_refund_type(payment)
        if record.rejected?
          :full
        elsif record.cancelled_at <= payment.created_at + CANCEL_DURATION_HALF
          if record.cancelled_at <= payment.created_at + CANCEL_DURATION_FULL
            :full
          else
            :half
          end
        end
      end

      def refund_not_applicable?(payment)
        record.draft? || refund_time_exceeded?(payment)
      end

      def refund_time_exceeded?(payment)
        record.cancelled_at > payment.created_at + CANCEL_DURATION_HALF
      end

      def self.policy_action
        :update?
      end
    end
  end
end
