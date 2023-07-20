# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "miHygge <admin@mihygge.com>"
  PAYMENT_ADMIN = 'payment@mihygge.com'
  CHECKR_ADMIN = 'screen@mihygge.com'
  MISCELLANEOUS_ADMIN = 'admin@mihygge.com'
  def send_reset_pwd_instructions(user, token, is_admin)
    @user = user
    @token = token
    @is_admin = is_admin
    mail(to: user.email, subject: 'Reset password instructions')
  end

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.first_name} <#{user.email}>", subject: 'Registration Confirmation')
  end

  def send_to_remind_buy_subscription(user)
    @user = user
    @full_name = user.full_name
    @pending_cares = user.cares.where(cares: { status: 'pending' })
    mail(to: user.email, subject: 'Subscription reminder')
  end

  def send_status_update(care_id, amount, user_id, is_admin)
    @user = User.find_by(id: user_id)
    @care = Care.find_by(id: care_id)
    @is_admin = is_admin ? true : false
    @amount = amount
    @full_name = @user.full_name
    @subject = @care.active? ? 'Care is Approved and Active' : 'Verification failure'
    @admin_email = MISCELLANEOUS_ADMIN
    unless is_admin
      @subject =  'Cancellation of subscription is successful'
      @admin_email = PAYMENT_ADMIN
    end
    mail(to: "#{@user.first_name} <#{@user.email}>", subject: @subject,
         cc: @admin_email)
  end

  def provider_status_mail(user_id)
    @user = User.find_by(id: user_id)
    @full_name = @user.full_name
    @subject = @user.approved? ? 'Add Bank Details' : 'Verification failure'
    mail(to: "#{@user.first_name} <#{@user.email}>", subject: @subject,
         cc: MISCELLANEOUS_ADMIN)
  end

  def send_payment_update(care_id, total_amount, user_id, status)
    @user = User.find_by(id: user_id)
    @care = Care.find_by(id: care_id)
    @amount = total_amount
    @full_name = @user.full_name
    @success = status == 'success'
    @subject = @success ? 'Payment for subscription is successful' : 'Payment failed'
    mail(to: "#{@user.first_name} <#{@user.email}>", subject: @subject,
         cc: PAYMENT_ADMIN)
  end

  def send_recurring_payment_update(status)
    @user = params[:user]
    @full_name = @user.full_name
    @status = status
    @subject = status == 'inactive' ? 'failed subscription renewal' : 'subscription successfully renewed'
    mail(to: "#{@user.first_name} <#{@user.email}>", subject: @subject,
         cc: PAYMENT_ADMIN)
  end

  def send_checkr_status(status, link = nil)
    @user = params[:user]
    @full_name = @user.full_name
    @status = status
    @url = link
    @subject = status == 'checkr_pending' ? 'Initiation of verification process' : 'Checkr verification status and next steps'
    @subject = 'checker invitation' if @status == 'initiate'
    mail(to: "#{@user.first_name} <#{@user.email}>", subject: @subject,
         cc: CHECKR_ADMIN)
  end

  def send_reminder_to_fill_checkr_form
    @user = params[:user]
    @full_name = @user.full_name
    mail(to: "#{@user.first_name} <#{@user.email}>", subject: 'checkr form pending')
  end

  def docusign_status_mail(user_id)
    @user = User.find_by(id: user_id)
    @full_name = @user.full_name
    @subject = 'Docusign process is completed'
    mail(to: "#{@user.first_name} <#{@user.email}>", subject: @subject,
         cc: MISCELLANEOUS_ADMIN)
  end
end
