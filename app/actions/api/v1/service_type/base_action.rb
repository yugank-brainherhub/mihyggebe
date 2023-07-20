# frozen_string_literal: true

module API
  module V1
    class ServiceType::BaseAction < Abstract::BaseAction
      def self.record_class
        ::ServiceType
      end

      def scope
        @scope ||= ::ServiceType.includes(:services).where(available_for: [params[:care_type], ALL_CARE])
      end

      def self.policy_class
        API::V1::ServiceTypePolicy
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
