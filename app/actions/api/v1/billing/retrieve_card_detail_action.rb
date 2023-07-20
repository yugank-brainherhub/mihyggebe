# frozen_string_literal: true

class API::V1::Billing::RetrieveCardDetailAction < Abstract::BaseAction
  attr_accessor :cards
  def perform
    @card_detail = fetch_card_detail
    @success = true
  end

  def fetch_card_detail
    card_id = Stripe::Customer.retrieve(current_user.stripeID).default_source
    @cards = Stripe::Customer.list_sources(current_user.stripeID)
  rescue Stripe::InvalidRequestError => e
    @cards = []
    Bugsnag.notify(e)
  end

  def filter_data
    cards.map do |card|
      { expiry_month: card.exp_month,
        expiry_year: card.exp_year,
        last4: card.last4,
        holder_name: card.name,
        id: card.id }
    end
  end

  def data
    filter_data
  end

  def authorize!
    true
  end
end
