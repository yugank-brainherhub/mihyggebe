# frozen_string_literal: true

class StripeJob < ApplicationJob
  queue_as :default

  def perform(params)
    subscription = ::Subscription.find_by(subscriptionId: params.fetch(:subscription))
    user = subscription.user
    care = subscription.care
    case params.fetch(:type)
    when 'invoice.payment_action_required', 'invoice.payment_failed'
      update_details(subscription, 'inactive', 'pending', user, care)
    when 'invoice.payment_succeeded'
      update_details(subscription, 'active', 'in-progress', user, care)
      subscription.update(subscribed_at: Time.current, payment_intent: params.fetch(:payment_intent))
    end
  end

  def update_details(subscription, subscription_status, care_status, user, care)
    subscription.update(status: subscription_status)
    care.update(status: care_status)
    UserMailer.with(user: user).send_recurring_payment_update(subscription_status).deliver
  end
end