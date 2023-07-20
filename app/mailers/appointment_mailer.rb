# frozen_string_literal: true

class AppointmentMailer < ApplicationMailer
  default from: 'miHygge <admin@mihygge.com>'
  ADMIN_EMAIL = 'admin@mihygge.com'

  def ask_for_demo(params)
    @name = params[:name]
    @email = params[:email]
    @title = params[:title]
    @phone = params[:phone]
    @date = params[:pst_date]
    @time_zone = params[:time_zone]
    @time = params[:pst_time]
    @additional = params[:additional]
    mail(to: ADMIN_EMAIL, subject: 'Demo Requested')
  end
end
