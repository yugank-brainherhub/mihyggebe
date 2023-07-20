# frozen_string_literal: true

module API
  module V1
    class Room::DestroyAction < Room::BaseAction
      def perform
        @success = record.destroy!
      end

      def self.policy_action
        :destroy?
      end
    end
  end
end
