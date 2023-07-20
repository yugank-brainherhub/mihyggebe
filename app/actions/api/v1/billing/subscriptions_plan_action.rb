# frozen_string_literal: true

class API::V1::Billing::SubscriptionsPlanAction < Abstract::BaseAction
  attr_accessor :stripe_plans
  def perform
    @stripe_plans = Plan.where(:has_bed => true).where(:status => 0).order("min, is_yearly") #Stripe::Plan.list.data.reject { |p| p.nickname == 'checkr' }
    @success = true
  rescue Stripe::InvalidRequestError => e
    Bugsnag.notify(e)
  end

  def data
    {type: 'list', data: stripe_plans}
  end

  def authorize!
    true
  end
end
