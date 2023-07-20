# frozen_string_literal: true

class Api::V1::RoomsController < API::V1::ApplicationController
  # POST /rooms/create
  def create
    perform API::V1::Room::CreateAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # GET /rooms/:id
  def show
    perform API::V1::Room::ShowAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # GET /rooms/:id
  def update
    perform API::V1::Room::UpdateAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # GET /rooms/:id/view_room
  def view_room
    perform API::V1::Room::ViewRoomAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # DELETE /api/rooms/:id
  def destroy
    perform API::V1::Room::DestroyAction do
      return head :no_content
    end
    render_action_error @action
  end

  # GET api/rooms/view_filtered_room
  def view_filtered_room
    perform API::V1::Room::ViewFilteredRoomAction do
      return render json: @action.data
    end
    render_action_error @action
  end

  # GET api/rooms/view_filtered_room
  def view_filtered_bed
    perform API::V1::Room::ViewFilteredBedAction do
      return render json: @action.data
    end
    render_action_error @action
  end
end
