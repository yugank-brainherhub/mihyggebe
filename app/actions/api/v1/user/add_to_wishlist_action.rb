# frozen_string_literal: true

module API
  module V1
    class User::AddToWishlistAction < User::BaseAction
      def perform
        @success = add_to_wishlist!
      end

      def data
        API::V1::WishlistSerializer.new(@wishlist)
      end

      def add_to_wishlist!
        @care = ::Care.where(id: params[:care_id]).first
        if false && !@care.active?
          return fail_with_error(422, :user, I18n.t('user.care_error'))
        end
        @wishlist = record.wishlists.new(care_id: params[:care_id])
        return true if @wishlist.save
        fail_with_error(422, :user, I18n.t('user.invalid_care'))
      end

      def authorize!
        true
      end
    end
  end
end
