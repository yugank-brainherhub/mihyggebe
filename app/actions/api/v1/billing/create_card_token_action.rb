# frozen_string_literal: true

class API::V1::Billing::CreateCardTokenAction < Abstract::BaseAction
  attr_accessor :new_card, :stripe_customer

  def perform
    if current_user.stripeID.nil?
      @stripe_customer = create_stripe_customer(permitted_params[:card_token])
      return fail_with_error(422, :user, stripe_customer) if stripe_customer[:error].present?

      current_user.update(stripeID: stripe_customer.id)
    else
      @new_card = add_new_card(permitted_params[:card_token])
      return fail_with_error(422, :user, new_card) if new_card[:error].present?
    end
    @success = true
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
    { new_card_added: new_card,
      new_customer_created: stripe_customer }
  end

  def permitted_params
    params.permit(:card_token)
  end

  def authorize!
    true
  end
end
