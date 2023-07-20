# frozen_string_literal: true

module Api
  module V1
    class BookingsController < API::V1::ApplicationController

      # POST /api/bookings

      def booking_rcfe_form
        booking = ::Booking.find_by(bookingID: params[:id])
      end
      def create
        perform API::V1::Booking::CreateAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # PUT /api/bookings/:id
      def update
        perform API::V1::Booking::UpdateAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # GET /api/bookings/:id
      def show
        booking = ::Booking.find_by(id: params[:id])


        res = if booking.present?
          beds = booking.beds

                { id:         booking.id,
                  status:     booking.status,
                  bookingID:  booking.bookingID,
                  care_name:  booking.care.name,
                  no_of_beds: booking.no_of_guests,
                  room:       beds.first.room.room_type,
                  bed_type:   beds.pluck(:bed_type).join(', ') }
              else
                {}
              end

        render json: res, status: :ok
      end

      # POST /api/payment
      def payment
        perform API::V1::Booking::PaymentAction do
          return render json: @action.data
        end
        render_action_error @action
      end
    end
  end
end
