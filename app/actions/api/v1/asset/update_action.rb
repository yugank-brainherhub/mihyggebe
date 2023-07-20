# frozen_string_literal: true

module API
  module V1
    class Asset::UpdateAction < Asset::BaseAction
      def perform
        @success = update_record!
      end

      def update_record!
        return true if record.update(permitted_params)

        fail_with_error(422, self.class.record_type, record.errors)
      end

      def data
        API::V1::AssetSerializer.new(record)
      end

      def self.policy_action
        :update?
      end
    end
  end
end
