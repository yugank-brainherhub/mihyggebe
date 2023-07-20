# frozen_string_literal: true

module API
  module V1
    class Role::BaseAction < Abstract::BaseAction
      def self.record_class
        ::Role
      end

      def scope
        @scope ||= ::Role.all
      end

      def self.policy_class
        API::V1::RolePolicy
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
