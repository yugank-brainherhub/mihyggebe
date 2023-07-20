# frozen_string_literal true

module API
  module V1
    class Booking::BaseAction < Abstract::BaseAction
      def self.record_class
        ::Booking
      end

      def scope
        @scope ||= ::Booking.all
      end

      def self.policy_class
        API::V1::BookingPolicy
      end

      def record
        @record ||= scope.find(params[:id])
      end

      def self.policy_action
        :index?
      end

      def bed_params
        { bed_bookings_attributes: %w[id booking_id bed_id] }
      end

      def booking_params
        %w[id first_name last_name email checkin checkout mobile
          arrival_time no_of_guests user_id care_id doc_received status other_relation]
      end

      def permitted_params
        params.require(:booking).permit(booking_params, bed_params ,relationship_ids: [])
      end
    end
  end
end
