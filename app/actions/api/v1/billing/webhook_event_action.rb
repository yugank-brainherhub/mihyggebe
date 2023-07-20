# frozen_string_literal: true

class API::V1::Billing::WebhookEventAction < Abstract::BaseAction
  attr_accessor :user, :care, :subscription

  def perform
    StripeJob.new(params).perform_now
    @success = true
  end

  def data
    true
  end

  def authorize!
    true
  end
end
