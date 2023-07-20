# frozen_string_literal: true

class TransferJob < ApplicationJob
  queue_as :default
  
  MIH_COMMISSION_PERCENT = 20
  HALF_CANCEL_INTERVAL = Rails.env.production? ? 72.hours : 15.minutes
  FULL_CANCEL_INTERVAL = Rails.env.production? ? 15.days : 30.minutes
  
  def perform(*args)
    booking = ::Booking.find(args.first)
    return if booking.terminated? || booking.rejected?

    payment = booking.payment
    amount = if booking.cancelled?
               cancel_duration = booking.cancelled_at - booking.created_at
               zero_transfer = 0
               if cancel_duration <= HALF_CANCEL_INTERVAL
                 zero_transfer
               elsif (cancel_duration > HALF_CANCEL_INTERVAL) && (cancel_duration <= FULL_CANCEL_INTERVAL)
                 payment.amount/2
               else
                 payment.amount
               end
             else
               payment.amount
             end
    return if amount == 0
    account_id = booking.care.user.accountId
    mih_commission = calculate_percent(amount, MIH_COMMISSION_PERCENT)
    provider_amount = (amount - mih_commission).round(2)
    begin
      transfer = transfer_to_provider(provider_amount.to_i, account_id)
      Transfer.create!(provider_amount: provider_amount,
                      mih_commission_amt: mih_commission,
                      transferId: transfer.id,
                      booking: booking,
                      payment: payment,
                      status: status(transfer))
    rescue StandardError => e
      Bugsnag.notify(e)
    end
  end

  def status(transfer)
    transfer.destination.present? ? 'paid' : 'rejected'
  end

  def transfer_to_provider(amount, account_id)
    Stripe::Transfer.create(
      amount: amount,
      currency: 'usd',
      destination: account_id
    )
  end

  def calculate_percent(value, percent)
    ans = (value * percent).to_f / 100
    return ans.round if ans < ans.round

    ans.round(2)
  end
end
