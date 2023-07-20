# frozen_string_literal: true

module API
  module V1
    class Care::ViewCareAction < Care::BaseAction
      attr_accessor :care

      def perform
        if record.user == current_user || current_user.customer? || current_user.social_worker?
          @success = !record.nil?
        else
          fail_with_error(422, :user, error: 'unmatched user')
        end
      end

      def data
        API::V1::ViewCareSerializer.new(record, params: {user_id: current_user.id, **extra_params})
      end

      def extra_params
        unless current_user.provider?
          booked_beds_count = ::Room.current_availability(record.rooms, params[:checkin], params[:checkout])
          return { count: booked_beds_count }
        end

        {}
      end

      def authorize!
        true
      end
    end
  end
end
