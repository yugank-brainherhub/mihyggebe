# frozen_string_literal: true

module API
  module V1
    class Relationship::CreateAction < Relationship::BaseAction
      def self.policy_action
        :create?
      end

      def data
        API::V1::RelationshipSerializer.new(record)
      end

      def perform
        @success = save_record!
      end

      def save_record!
        return true if record.save

        fail_with_error(422, self.class.record_type, record.errors)
      end

      def record
        @record ||= self.class.record_class.new(permitted_params)
      end

      def authorize!
        true
      end
    end
  end
end
