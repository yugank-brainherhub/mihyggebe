# frozen_string_literal: true

class API::V1::Billing::SubscribeAction < Abstract::BaseAction
  attr_accessor :subscription, :completed_subscriptions, :applicable_plan_ids, :care_details,
                :state_match, :one_time_charge, :failed_subscriptions, :checkr_added_to_care

  CONVEINIENCE_FEE = 2
  CHECKER_FEE = 10000#3500
  DISCOUNT_PERCENT = 10
  def perform
    if current_user.docusign_status != 'Completed'
      return fail_with_error(422, :user, I18n.t('stripe.docusign_fail'))
    end

    @completed_subscriptions = []
    @failed_subscriptions = []
    @applicable_plan_ids = []
    @care_details = CareDetail.cares_ready_for_subscription(current_user)
    @state_match = true
    if current_user.stripeID.nil?
      stripe_customer = create_stripe_customer(permitted_params[:card_token])
      return fail_with_error(422, :user, stripe_customer) if stripe_customer[:error].present?

      current_user.update(stripeID: stripe_customer.id)
    elsif !current_user.stripeID.nil? && permitted_params[:card_token].present?
      new_card = add_new_card(permitted_params[:card_token])
      return fail_with_error(422, :user, new_card) if new_card[:error].present?

      update_card(new_card.id)
    else
      update_card(permitted_params[:card_id])
    end
    customer = current_user.stripeID
    if !customer.nil?
      @plan_for_checker = Plan.plan_according_bed(care_detail.no_of_beds)
      @checkr_added_to_care = false
      care_details.compact.map do |care_detail|
        plan = Plan.plan_according_bed(care_detail.no_of_beds)
        plan_id = plan.planId
        applicable_plan_ids << plan_id
        applicable_taxes = attach_tax(care_detail.care)
        if applicable_taxes.is_a?(Hash)
          @state_match = false
          break
        end
        subscription_create_params = { customer: customer,
                                       items: [{ plan: plan_id, tax_rates: applicable_taxes }],
                                       expand: ['latest_invoice.payment_intent']
                                     }
        if false && first_time_user?
          subscription_create_params[:coupon] = Stripe::Coupon.list.data.last.id
        end

        if false && plan.has_trial_period?
          subscription_create_params[:trial_end] = (Time.now + 180.days).to_i 
        end  

        total_amount = (calculate_amount(plan, care_detail.care.state.upcase) / 100).round(2)
        @subscription = create_subscription(subscription_create_params)
        return fail_with_error(422, :user, subscription) if subscription[:error].present?
      
        if subscription.status == 'active'
          completed_subscriptions << subscription
          sub = current_user.subscriptions.create(
            planId: plan_id,
            subscriptionId: subscription.id,
            care: care_detail.care,
            subscribed_at: Time.current,
            status: 'active'
          )
          care_detail.care.update(status: 'in-progress')
          Package.create(subscription: sub, plan: plan)
          UserMailer.send_payment_update(care_detail.care.id, total_amount, current_user.id, 'success').deliver_now
        else
          failed_subscriptions << subscription
          UserMailer.send_payment_update(care_detail.care.id, total_amount, current_user.id, 'failed').deliver_now
        end
        current_user.update(email_sent: false)
      end

      if first_time_user? && @plan_for_checker
        
        check_consume_plan =  [69, 71, 72, 74, 75, 77, 78, 80, 81, 83, 84, 67, 68, 70, 73, 76, 79, 82, 85]  
         
          unless check_consume_plan.include?(@plan_for_checker.id) 
          checkr_plan = -35
          plan = Plan.plan_according_bed(checkr_plan)
          plan_id = plan.planId
          subscription_create_params = { customer: customer,
                                         items: [{ plan: plan_id }],
                                         expand: ['latest_invoice.payment_intent'] }
          checkr_subscription = create_subscription(subscription_create_params)
          failed_subscriptions << checkr_subscription if checkr_subscription[:error].present? || checkr_subscription.status == 'incomplete'
          if !checkr_subscription[:error].present?
            completed_subscriptions << checkr_subscription
            sub = current_user.subscriptions.create(
              planId: plan_id,
              subscriptionId: checkr_subscription.id,
              care: care_details.first.care,
              subscribed_at: Time.current
            )
            Package.create(subscription: sub, plan: plan)
         end  
          CheckerJob.perform(current_user.id)
          current_user.update(first_time: false)
          current_user.update(checker_paid_date: Date.today, checker_future_payment: Date.today + 1.year)
        end
      end
      @success = true
    else
      fail_with_error(422, :user, I18n.t('stripe.customer_fail'))
    end
    unless state_match
      fail_with_error(422, :user, I18n.t('stripe.state_absent'))
    end
  end

  def create_subscription(subscription_create_params)
    Stripe::Subscription.create(subscription_create_params)
  rescue StandardError => e
    { error: e.message, status: 'incomplete' }
  end

  def create_subscription1(subscription_create_params)
    puts "*********************************************"
    da = Stripe::Subscription.create(subscription_create_params)
    puts da.inspect
    return da
 # rescue StandardError => e
 #   { error: e.message, status: 'incomplete' }
  end

  def first_time_user?
    current_user.role.name == 'provider' && current_user.first_time
  end

  def check_if_all_subscription_created
    return completed_subscriptions if completed_subscriptions.present?

    { failed_subscriptions: failed_subscriptions }
  end

  def failed_subscription_plans
    completed_subscriptions.map do |subscription|
      next if applicable_plan_ids.include?(subscription.plan.id)

      subscription
    end
  end

  def attach_tax(care)
    convenience = create_tax('tax1', 'conveinience')
    tax_according_state = fetch_tax_according_state(care.state.upcase)
    return tax_according_state if tax_according_state.is_a?(Hash)

    state_tax = create_tax('tax2', 'state tax', tax_according_state)
    [convenience.id, state_tax.id]
  end

  def create_tax(display_name, description, percent = CONVEINIENCE_FEE)
    Stripe::TaxRate.create(
      display_name: display_name,
      description: description,
      percentage: percent,
      inclusive: false
    )
  rescue Stripe::InvalidRequestError => e
    Bugsnag.notify(e)
  end

  def fetch_tax_according_state(state)
    TAXES.fetch(state.to_sym)
  rescue StandardError => e
    { error: e.message }
  end

  def update_card(card_token)
    Stripe::Customer.update(
      current_user.stripeID,
      default_source: card_token,
      invoice_settings: { default_payment_method: card_token }
    )
  rescue StandardError => e
    { error: e.message }
  end

  def create_stripe_customer(card_id)
    Stripe::Customer.create(
      description: "Customer for #{current_user.email}",
      email: current_user.email,
      source: card_id
    )
  rescue StandardError => e
    { error: e.message }
  end

  def add_new_card(card_token)
    Stripe::Customer.create_source(
      current_user.stripeID,
      source: card_token
    )
  rescue StandardError => e
    { error: e.message }
  end

  def data
    { subscription: check_if_all_subscription_created }
  end

  def checker_charge_response
    filtered_charge_object(one_time_charge) unless one_time_charge.nil?
  end

  def calculate_tax(plan_amount, state)
    state_tax_percent = fetch_tax_according_state(state)
    state_tax = calculate_percent(plan_amount, state_tax_percent)
    convenience_tax = calculate_percent(plan_amount, CONVEINIENCE_FEE)
    state_tax + convenience_tax
  end

  def calculate_percent(value, percent)
    (value * percent).to_f / 100
  end

  def calculate_amount(plan, state)
    plan_amount = plan.price
    tax_amount = calculate_tax(plan_amount, state)
    total_amount = plan_amount + tax_amount
    if first_time_user?
      total_amount -= calculate_percent(total_amount, DISCOUNT_PERCENT)
      if !checkr_added_to_care
        total_amount += CHECKER_FEE
        @checkr_added_to_care = true
      end
    end
    total_amount
  end

  def permitted_params
    params.permit(:card_token, :card_id)
  end

  def authorize!
    true
  end
end
