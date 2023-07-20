# frozen_string_literal: true

class API::V1::Billing::AddBankDetailAction < Abstract::BaseAction
  attr_accessor :bank_details, :external_account

  def perform
    @bank_details = create_bank_details
    if bank_details[:error].present?
      return fail_with_error(422, :user, error: bank_details)
    end

    @external_account = create_external_account
    return fail_with_error(422, :user, error: external_account) if external_account[:error].present?

    add_external_bank_to_account
    @success = true if current_user.update(accountId: bank_details.id)
  end

  def add_external_bank_to_account
    Stripe::Account.create_external_account(
      bank_details.id,
      external_account: external_account.id
    )
  end

  def create_external_account
    external_account = Stripe::Token.create(
      bank_account: {
        country: 'US',
        currency: 'usd',
        account_holder_name: current_user.full_name,
        account_holder_type: permitted_params[:business_type],
        routing_number: permitted_params[:routing_number],
        account_number: permitted_params[:bank_account]
      }
    )
  rescue StandardError => e
    Bugsnag.notify(e)
    { error: e.message }
  end

  def create_bank_details
    Stripe::Account.create(
      type: 'custom',
      country: 'US',
      email: current_user.email,
      business_type: permitted_params[:business_type],
      requested_capabilities: %w[
        card_payments
        transfers
      ],
      tos_acceptance: { date: Time.now.to_i, ip: params[:ip] }
    )
  rescue StandardError => e
    Bugsnag.notify(e)
    { error: e.message }
  end

  def data
    { msg: I18n.t('stripe.bank_added') }
  end

  def permitted_params
    params.require(:billing).permit(:bank_account, :routing_number, :business_type)
  end

  def authorize!
    true
  end
end
