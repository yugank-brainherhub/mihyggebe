# frozen_string_literal: true

module API
  module V1
    class Room::BaseAction < Abstract::BaseAction
      def self.record_class
        ::Room
      end

      def scope
        @scope ||= ::Room.all
      end

      def self.policy_class
        API::V1::RoomPolicy
      end

      def record
        @record ||= scope.find(params[:id])
      end

      def room_service_params
        { selected_room_services_attributes: %i[id name room_service_type_id room_service_id _destroy] }
      end

      def room_params
        %i[id name room_type bathroom_type price available_from available_to price_desc care_id]
      end

      def bed_params
        { beds_attributes: %i[id bed_number bed_type service_id _destroy] }
      end

      def permitted_params
        params.require(:room).permit(room_params, room_service_params, bed_params)
      end
    end
  end
end
