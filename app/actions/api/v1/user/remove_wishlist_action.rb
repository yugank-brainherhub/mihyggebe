# frozen_string_literal: true

module API
  module V1
    class User::RemoveWishlistAction < User::BaseAction
      def perform
        @success = record.wishlists.where(care_id: params[:care_id]).first.destroy!
      end

      def self.policy_action
        :destroy?
      end
    end
  end
end
