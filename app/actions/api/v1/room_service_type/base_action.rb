# frozen_string_literal: true

module API
  module V1
    class RoomServiceType::BaseAction < Abstract::BaseAction
      def self.record_class
        ::RoomServiceType
      end

      def scope
        @scope ||= ::RoomServiceType.includes(:room_services).all
      end

      def self.policy_class
        API::V1::RoomServiceTypePolicy
      end

      def record
        @record ||= scope.find(params[:id])
      end

      def self.policy_action
        :index?
      end
    end
  end
end
