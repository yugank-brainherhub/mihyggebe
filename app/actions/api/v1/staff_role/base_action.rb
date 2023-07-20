# frozen_string_literal: true

module API
  module V1
    class StaffRole::BaseAction < Abstract::BaseAction
      def self.record_class
        ::StaffRole
      end

      def scope
        @scope ||= ::StaffRole.all
      end

      def self.policy_class
        API::V1::StaffRolePolicy
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
