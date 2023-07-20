# frozen_string_literal: true

module Api
  module V1
    class BillingsController < API::V1::ApplicationController
      skip_before_action :authenticate_user!, only: %i[webhook_event stripe_account_update]

      # Get /api/billings/create_card_token
      def create_card_token
        perform API::V1::Billing::CreateCardTokenAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end

      # Put /api/billings/update_card
      def update_card
        perform API::V1::Billing::UpdateCardAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end

      # Post /api/billings/subscribe
      def subscribe
        perform API::V1::Billing::SubscribeAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end

      # Get /admin/billings/subscriptions_plan
      def subscriptions_plan
        perform API::V1::Billing::SubscriptionsPlanAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end

      # Post /api/billings/reattempt_payment
      def reattempt_payment
        perform API::V1::Billing::ReattemptPaymentAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end

      # Post /api/billings/cancel_subscription
      def cancel_subscription
        perform API::V1::Billing::CancelSubscriptionAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end

      # GET /api/billings/view_subscription
      def view_subscription
        perform API::V1::Billing::ViewSubscriptionAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end

      # GET /api/billings/view_subscription
      def set_care_plan
        perform API::V1::Billing::SetCarePlanAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end


      # GET /api/billings/retrieve_card_detail
      def retrieve_card_detail
        perform API::V1::Billing::RetrieveCardDetailAction do
          return render json: @action.data, status: :ok
        end
      end

      # GET /api/billings/subscription_checkout
      def subscription_checkout
        perform API::V1::Billing::SubscriptionCheckoutAction do
          return render json: @action.data, status: :ok
        end
      end

      # POST /api/billings/add_bank_details
      def add_bank_details
        params.merge!(ip: request.remote_ip)

        perform API::V1::Billing::AddBankDetailAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end

      # POST /api/billings/add_bank_details_company
      def add_bank_details_company
        params.merge!(ip: request.remote_ip)
        perform API::V1::Billing::AddBankDetailCompanyAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end

      # GET /api/billings/show_bank_detail
      def show_bank_details
        perform API::V1::Billing::ShowBankDetailsAction do
          return render json: @action.data, status: :ok
        end

        render_action_error @action
      end

      def webhook_event
        event = Stripe::Event.construct_from(
          JSON.parse(request.body.read, symbolize_names: true)
        )
        subscription = event.data.object.lines.data.first.subscription
        payment_intent = event.data.object.payment_intent
        params.merge!(subscription: subscription, payment_intent: payment_intent)
        perform API::V1::Billing::WebhookEventAction do
          return render json: @action.data, status: :ok
        end

        head :ok
      end

      def stripe_account_update
        event = Stripe::Event.construct_from(
          JSON.parse(request.body.read, symbolize_names: true)
        )

        acc_id = event.account

        user = ::User.find_by(accountId: acc_id)
        user.update_columns(payouts_enabled: event.data.object.payouts_enabled) if user

        # Always you have to render HTTP status as :ok to stripe webhook event. Otherwise stripe won't call
        # that webhook again in production
        head :ok
      end
    end
  end
end
