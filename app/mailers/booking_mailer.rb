# frozen_string_literal: true

class BookingMailer < ApplicationMailer
  default from: "miHygge <admin@mihygge.com>"

  def status_update(booking)
    @user = booking.user
    @care = booking.care
    @booking = booking
    @refund_amount = booking.refund&.amount.nil? ? 0 : booking.refund.amount
    @full_name = @user.full_name
    @room = booking.beds.first.room
    @beds = booking.beds
    @payment = booking.payment
    @services = ::Service.where('id IN (?)', @beds.pluck(:service_id))
    subject = case booking.status
              when 'accepted' then 'miHygge - Booking request accepted' 
              when 'rejected' then 'miHygge - Booking request rejected'
              when 'terminated' then 'miHygge - Booking terminated'
              when 'cancelled' then 'miHygge - Booking cancelled'
              end
    mail(to: @user.email, subject: subject)
  end

  def doc_update(booking)
    @user = booking.user
    @care = booking.care
    @booking = booking
    @full_name = @user.full_name
    mail(to: @user.email, subject: 'miHygge - Documents received')
  end

  def send_payment_mail(booking, payment_status)
    @booking = booking
    @user = params[:user]
    @status = payment_status
    @care = booking.care
    @room = booking.beds.first.room
    @beds = booking.beds
    @payment = booking.payment
    @services = ::Service.where('id IN (?)', @beds.pluck(:service_id))
    subject = payment_status == 'succeeded' ? 'miHygge - Payment successful for your booking ': 'miHygge - Payment declined for your booking'
    mail(to: @user.email, subject: subject)
  end

end
