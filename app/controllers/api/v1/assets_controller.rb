# frozen_string_literal: true

class Api::V1::AssetsController < API::V1::ApplicationController
  # POST /assets/create
  def create
    perform API::V1::Asset::CreateAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # PUT /api/assets/:id
  def update
    perform API::V1::Asset::UpdateAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # DELETE /api/assets/:id
  def destroy
    perform API::V1::Asset::DestroyAction do
      return head :no_content
    end
    render_action_error @action
  end
end
