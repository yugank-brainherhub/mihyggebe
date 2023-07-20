# frozen_string_literal: true

module API
  module V1
    class FacilityType::BaseAction < Abstract::BaseAction
      def self.record_class
        ::FacilityType
      end

      def scope
        @scope ||= ::FacilityType.includes(:facilities).all
      end

      def self.policy_class
        API::V1::FacilityTypePolicy
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
