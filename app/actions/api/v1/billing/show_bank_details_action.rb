class API::V1::Billing::ShowBankDetailsAction < Abstract::BaseAction
  attr_accessor :account
  def perform
    @account = Stripe::Account.retrieve(current_user.accountId)
    @success = true
  end

  def data
    filter_data
  end

  def filter_data
    business_profile = account.business_profile.to_h
    individual = account.individual
    dob = individual.dob.to_h
    address = individual.address.to_h
    detail = individual.to_h
    bank_account = account.external_accounts.data.first.to_h

    { business_type: account.business_type,
      **business_profile.slice(:product_description, :url),
      **detail.slice(:ssn_last_4_provided, :phone),
      **bank_account.slice(:last4, :routing_number),
      **dob,
      **address }
  end

  def authorize!
    true
  end
end