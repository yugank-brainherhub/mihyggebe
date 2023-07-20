# frozen_string_literal: true

class API::V1::Billing::SubscriptionCheckoutAction < Abstract::BaseAction
  attr_accessor :care_details, :valid_care_details, :total_plan_sum, :total_state_taxes_sum,
                :total, :total_payable_amount, :total_convenience_fee_sum

  CONVENIENCE_FEE = 2
  CHECKER_FEE = 3500

  def perform
    @care_details = CareDetail.cares_ready_for_subscription(current_user)
    @valid_care_details = filter_with_available_state
    @total_plan_sum = calculate_total_subscription_sum
    @total_state_taxes_sum = calculate_total_state_taxes
    @total_convenience_fee_sum = calculate_convenience_fee_sum.to_f
    @total = total_plan_sum + total_state_taxes_sum + checkr_fee
    @total_payable_amount = total + @total_convenience_fee_sum
  end

  def data
    {
      total_subscription_amount: total_plan_sum,
      taxes: total_state_taxes_sum,
      back_ground_check: checkr_fee,
      total: total,
      convinience_fee: total_convenience_fee_sum,
      total_payable_amount: total_payable_amount
    }
  end

  def checkr_pending?
    (current_user.role.name == 'provider' && current_user.first_time)
  end

  def checkr_fee
    checkr_pending? ? CHECKER_FEE : 0.0
  end

  def calculate_total_subscription_sum
    plan_prices = valid_care_details.map do |care_detail|
      Plan.plan_according_id(care_detail.care.plan_id).price
    end
    price = plan_prices.inject(0) { |sum, x| sum + x }
    return (price - calculate_percent(price, 10)) if current_user.first_time?

    price
  end

  def filter_with_available_state
    care_details.map do |care_detail|
      care_state = care_detail.care.state.upcase
      care_detail if state_tax_applicable?(care_state)
    end
  end

  def calculate_total_state_taxes
    state_taxes_sum = valid_care_details.compact.map do |care_detail|
      plan_price = Plan.plan_according_id(care_detail.care.plan_id).price
      care_state = care_detail.care.state.upcase
      state_tax_percent = fetch_tax_according_state(care_state)

      calculate_percent(plan_price, state_tax_percent).to_f
    end

    sum = state_taxes_sum.inject(0) { |sum, x| sum + x }
    return (sum - calculate_percent(sum, 10)) if current_user.first_time?

    sum
  end

  def calculate_convenience_fee_sum()
    convenience_sum = valid_care_details.map do |care_detail|
      plan_price = Plan.plan_according_id(care_detail.care.plan_id).price
      calculate_percent(plan_price, CONVENIENCE_FEE)
    end

    sum = convenience_sum.inject(0) { |sum, x| sum + x }
    return (sum - calculate_percent(sum, 10)) if current_user.first_time?

    sum
  end

  def calculate_percent(value, percent)
    ans = (value * percent).to_f / 100
    return ans.round if ans < ans.round

    ans.round(2)
  end

  def fetch_tax_according_state(state)
    TAXES.fetch(state.to_sym)
  end

  def state_tax_applicable?(state)
    TAXES.include?(state.to_sym)
  end

  def authorize!
    true
  end
end
