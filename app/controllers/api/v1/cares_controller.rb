# frozen_string_literal: true

class Api::V1::CaresController < API::V1::ApplicationController
  skip_before_action :authenticate_user!, only: :search

  # POST /cares/create
  def create
    perform API::V1::Care::CreateAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # POST /cares/update
  def update
    perform API::V1::Care::UpdateAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # GET /cares/:id
  def show
    perform API::V1::Care::ShowAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # GET  /cares/:id/services
  def services
    perform API::V1::Care::ServicesAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # GET /cares/view_care/:id
  def view_care
    perform API::V1::Care::ViewCareAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # GET /cares/search
  def search
    params.merge!(user_id: user_id_in_token?)
    perform API::V1::Care::SearchAction do
      return render json: @action.data
    end
    render_action_error @action
  end
end
