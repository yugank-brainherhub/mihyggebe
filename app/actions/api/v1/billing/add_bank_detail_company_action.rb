# frozen_string_literal: true

class API::V1::Billing::AddBankDetailCompanyAction < Abstract::BaseAction
  attr_accessor :bank_details, :external_account, :upload_file2,
                :upload_file1

  INDUSTRY_CODE = 8050 # To represent personal care as default industry
  def perform
    validity_checker = check_parameter_validity
    if validity_checker.invalid?
      return fail_with_error(422, :user, error: validity_checker.errors.messages)
    end

    @bank_details = create_bank_details
    @external_account = create_external_account
    if bank_details[:error].present?
      return fail_with_error(422, :user, error: bank_details)
    end
    if external_account[:error].present?
      return fail_with_error(422, :user, error: external_account)
    end

    @upload_file1 = upload_to_stripe(permitted_params[:file1].path)
    @upload_file2 = upload_to_stripe(permitted_params[:file2].path)
    if upload_file1[:error].present?
      return fail_with_error(422, :user, error: upload_file1)
    end
    if upload_file2[:error].present?
      return fail_with_error(422, :user, error: upload_file2)
    end

    add_person_to_company
    add_external_bank_to_account
    @success = true if current_user.update(accountId: bank_details.id)
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
      company: {
        name: permitted_params[:company_name],
        owners_provided: true,
        tax_id: permitted_params[:ein],
        phone: permitted_params[:phone],
        address: { city: permitted_params[:city], country: 'US', line1: permitted_params[:line1],
                   line2: permitted_params[:line2], postal_code: permitted_params[:postal_code], state: permitted_params[:state] }
      },
      business_profile: { mcc: INDUSTRY_CODE, url: permitted_params[:website_url], product_description: permitted_params[:description] },
      tos_acceptance: { date: Time.now.to_i, ip: params[:ip] }
    )
  rescue StandardError => e
    Bugsnag.notify(e)
    { error: e.message }
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

  def add_person_to_company
    person = Stripe::Account.create_person(
      bank_details.id,
      first_name: current_user.first_name,
      last_name: current_user.last_name,
      phone: permitted_params[:phone],
      address: { city: permitted_params[:city], country: 'US', line1: permitted_params[:line1],
                 line2: permitted_params[:line2], postal_code: permitted_params[:postal_code], state: permitted_params[:state] },
      dob: { day: permitted_params[:day], month: permitted_params[:month], year: permitted_params[:year] },
      email: current_user.email,
      ssn_last_4: permitted_params[:ssn],
      relationship: {
        title: permitted_params[:title],
        director: false,
        executive: true,
        owner: false,
        representative: true
      },
      verification: {
        document: {
          back: upload_file2.id,
          front: upload_file1.id
        }
      }
    )
  end

  def upload_to_stripe(path)
    Stripe::File.create(
      file: File.new(path),
      purpose: 'identity_document'
    )
  rescue StandardError => e
    Bugsnag.notify(e)
    { error: e.message }
  end

  def check_parameter_validity
    Validators::BankDetailValidatorCompany.new(permitted_params)
  end

  def data
    { msg: I18n.t('stripe.bank_added') }
  end

  def permitted_params
    params.permit(:ein, :business_type, :company_name, :bank_account, :routing_number, :ssn, :day, :month,
                  :year, :website_url, :country, :description, :city, :line1, :line2, :postal_code, :state, :phone,
                  :file1, :file2, :title, :ip)
  end

  def authorize!
    true
  end
end
