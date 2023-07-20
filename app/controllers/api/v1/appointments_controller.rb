# frozen_string_literal: true

class Api::V1::AppointmentsController < API::V1::ApplicationController
  skip_before_action :authenticate_user!, only: %i[ask_for_demo]

  # Post /api/appointments/ask_for_demo
  def ask_for_demo
    perform API::V1::Appointment::AskForDemoAction do
      return render json: @action.data, status: :ok
    end

    render_action_error @action
  end
end

