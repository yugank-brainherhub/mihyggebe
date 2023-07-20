# frozen_string_literal: true

class API::V1::Billing::ReattemptPaymentAction < Abstract::BaseAction
  attr_accessor :invoice

  def perfrom
    @invoice = invoice_repayment
    if invoice.payment_intent.status == 'succeeded'
      @success = true
    else
      fail_with_error(422, :user, I18n.t('stripe.payment_fail'))
    end
  end

  def invoice_repayment
    Stripe::Invoice.pay(
      invoice: permitted_params[:invoice_id],
      expand: ['payment_intent']
    )
  rescue Stripe::InvalidRequestError => e
    Bugsnag.notify(e)
  end

  def permitted_params
    params.permit(:invoice_id)
  end

  def authorize!
    true
  end

  def data
    invoice
  end
end
