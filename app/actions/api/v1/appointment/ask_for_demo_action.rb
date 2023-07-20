# frozen_string_literal: true

class API::V1::Appointment::AskForDemoAction < Abstract::BaseAction
  def perform
    validity_checker = check_parameter_validity
    if validity_checker.invalid?
      return fail_with_error(422, :user, error: validity_checker.errors.messages)
    end

    convert_to_pst
    AppointmentMailer.ask_for_demo(params).deliver_now
  end

  def check_parameter_validity
    Validators::AskForDemoValidator.new(params)
  end

  def convert_to_pst
    pst_time_zone = 'Pacific Time (US & Canada)'
    time = ActiveSupport::TimeZone["#{params[:time_zone]}"].parse("#{params[:date]} #{params[:time]}")
    time = time.in_time_zone(pst_time_zone)
    params.merge!(pst_date: time.to_date.to_s, pst_time: time.strftime('%I:%M %p'))
  end

  def authorize!
    true
  end

  def data
    { msg: true }
  end
end
