# frozen_string_literal: true

module API
  module V1
    class Bed::BaseAction < Abstract::BaseAction
      def self.record_class
        ::Bed
      end

      def scope
        @scope ||= ::Bed.all
      end

      def self.policy_class
        API::V1::BedPolicy
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
