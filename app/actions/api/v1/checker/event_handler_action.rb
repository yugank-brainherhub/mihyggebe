# frozen_string_literal: true

class API::V1::Checker::EventHandlerAction < Abstract::BaseAction
  def perform
    CheckrWebhookJob.new(params).perform_now
    @success = true
  end

  def authorize!
    true
  end

  def data
    true
  end

end

