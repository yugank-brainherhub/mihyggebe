# frozen_string_literal: true

module Api
  module V1
    class UsersController < API::V1::ApplicationController
      skip_before_action :authenticate_user!, only: %i[create login confirm_email test]

      # PUT /users/:id
      def create
        perform API::V1::User::CreateAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # GET /users/:id
      def show
        perform API::V1::User::ShowAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # GET /users/:id/account_url
      def account_url
        if current_user.accountId.present?
          connect = Stripe::AccountLink.create({
            account: current_user.accountId,
            failure_url: SECRETS[:FE_url] + '/stripe/callback/failure',
            success_url: SECRETS[:FE_url] + '/stripe/callback/success',
            type: 'custom_account_verification'
          })

          render json: { payouts_enabled: current_user.payouts_enabled,
                         url: connect["url"],
                         accId: current_user.accountId }, status: :ok
        else
          render json: { payouts_enabled: current_user.payouts_enabled,
                         url: "",
                         accId: current_user.accountId.to_s }, status: :ok
        end
      end

      # PUT /api/users/:id
      def update
        perform API::V1::User::UpdateAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # POST /users/login
      def login
        perform API::V1::User::LoginAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # POST /users/change_password
      def change_password
        perform API::V1::User::ChangePasswordAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # GET /users/confirm_email
      def confirm_email
        perform API::V1::User::ConfirmEmailAction do
          return redirect_to "#{Rails.application.credentials[Rails.env.to_sym][:FE_url]}/thankyou"
        end
        render_action_error @action
      end

      # GET  /users/:id/cares
      def cares
        perform API::V1::User::CaresAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # GET  /users/:id/add_to_wishlist
      def add_to_wishlist
        perform API::V1::User::AddToWishlistAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      # GET  /users/:id/remove_wishlist
      def remove_wishlist
        perform API::V1::User::RemoveWishlistAction do
          return head :no_content
        end
        render_action_error @action
      end

      def wishlists
        perform API::V1::User::WishlistsAction do
          return render json: @action.data
        end
        render_action_error @action
      end

      def bookings
        perform API::V1::User::BookingsAction do
          return render json: @action.data
        end
        render_action_error @action
      end
    end
  end
end
