# frozen_string_literal: true

module API
  module V1
    class Room::ShowAction < Room::BaseAction
      def perform
        @success = !record.nil?
      end

      def data
        API::V1::RoomSerializer.new(record, options)
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
