# frozen_string_literal: true

module API
  module V1
    class RoomType::BaseAction < Abstract::BaseAction
      def self.record_class
        ::RoomType
      end

      def scope
        @scope ||= ::RoomType.all
      end

      def self.policy_class
        API::V1::RoomTypePolicy
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
