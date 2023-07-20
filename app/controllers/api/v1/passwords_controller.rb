# frozen_string_literal: true

class Api::V1::PasswordsController < API::V1::ApplicationController
  skip_before_action :authenticate_user!

  # POST /passwords/create
  def create
    perform API::V1::Password::CreateAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  def update
    perform API::V1::Password::UpdateAction do
      return render json: @action.data
    end
    render_action_error @action
  end
end
