# frozen_string_literal: true

module API
  module V1
    class User::ShowAction < User::BaseAction
      def perform
        @success = !record.nil?
      end

      def data
        API::V1::UserSerializer.new(record, options)
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
