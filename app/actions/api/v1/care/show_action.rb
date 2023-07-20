# frozen_string_literal: true

module API
  module V1
    class Care::ShowAction < Care::BaseAction
      def perform
        @success = !record.nil?
      end

      def data
        API::V1::CareSerializer.new(record, params: { detail_type: params[:type], role: current_user.role.name })
      end

      def options
        @options = {}
        @options[:include] = include_param
        @options
      end

      def self.policy_action
        :show?
      end
    end
  end
end
