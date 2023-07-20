# frozen_string_literal: true

class API::V1::Billing::CancelSubscriptionAction < Abstract::BaseAction
  attr_accessor :cancelled_subscription, :refund

  def perform
    unless cancellation_applicable?
      return fail_with_error(422, :user, I18n.t('stripe.month_expire'))
    end

    unless subscription.present?
      return fail_with_error(422, :user, I18n.t('stripe.unsubscribe_fail'))
    end

    @cancelled_subscription = unsubscribe
    if cancelled_subscription
      create_refund_and_save_status
    else
      fail_with_error(422, :user, I18n.t('stripe.unsubscribe_fail'))
    end
    @success = true
  end

  def unsubscribe
    Stripe::Subscription.delete(subscription.subscriptionId)
  rescue Stripe::InvalidRequestError => e
    Bugsnag.notify(e)
  end

  def subscription
    @subscription ||= ::Subscription.joins(:plans)
                                    .where(care_id: permitted_params[:care_id])
                                    .where.not('plans.min = ? AND plans.max = ?', -35,-35)
                                    .where.not(payment_intent: nil)
                                    .first
  end

  def create_refund_and_save_status
    amount_to_refund = calculate_amount_to_refund(subscription)
    @refund = Stripe::Refund.create(amount: amount_to_refund, payment_intent: subscription.payment_intent)
    return unless refund

    subscription.create_subscription_refunds(description: refund.payment_intent,
                                             refundId: refund.id,
                                             status: refund.status)
    if record.update(status: 'cancelled')
      UserMailer.send_status_update(record.id, amount_to_refund, current_user.id, false).deliver_now
    end

    @success = true
  end

  def permitted_params
    params.permit(:care_id)
  end

  def calculate_amount_to_refund(subscription)
    invoice_id = Stripe::Subscription.retrieve(subscription.subscriptionId).latest_invoice
    invoice = Stripe::Invoice.retrieve(invoice_id)
    invoice.total - invoice.tax
  rescue Stripe::InvalidRequestError => e
    Bugsnag.notify(e)
  end

  def cancellation_applicable?
    subscription_date = record.subscription.created_at
    subscription_date <= subscription_date + 48.hours
  end

  def data
    { subscription_details: cancelled_subscription,
      refund_details: refund }
  end

  def authorize!
    true
  end

  def scope
    @scope ||= ::Care.all
  end

  def record
    @record ||= scope.find(params[:care_id])
  end
end
