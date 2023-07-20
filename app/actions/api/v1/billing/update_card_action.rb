# frozen_string_literal: true

class API::V1::Billing::UpdateCardAction < Abstract::BaseAction
  attr_accessor :card

  def perform
    update_card
  end

  def update_card
    Stripe::Customer.update(
      current_user.stripeID,
      default_source: permitted_params[:card_token],
      invoice_settings: { default_payment_method: permitted_params[:card_token] }
    )
  rescue Stripe::InvalidRequestError => e
    Bugsnag.notify(e)
  end

  def data
    true
  end

  def authorize!
    true
  end

  def permitted_params
    params.permit(:card_token)
  end
end
