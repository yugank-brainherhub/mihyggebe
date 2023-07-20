class RoomServiceTypesController < ApplicationController
  before_action :set_room_service_type, only: [:show, :edit, :update, :destroy]

  # GET /room_service_types
  def index
    @room_service_types = RoomServiceType.all
  end

  # GET /room_service_types/1
  def show
  end

  # GET /room_service_types/new
  def new
    @room_service_type = RoomServiceType.new
  end

  # GET /room_service_types/1/edit
  def edit
  end

  # POST /room_service_types
  def create
    @room_service_type = RoomServiceType.new(room_service_type_params)

    if @room_service_type.save
      redirect_to @room_service_type, notice: 'Room service type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /room_service_types/1
  def update
    if @room_service_type.update(room_service_type_params)
      redirect_to @room_service_type, notice: 'Room service type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /room_service_types/1
  def destroy
    @room_service_type.destroy
    redirect_to room_service_types_url, notice: 'Room service type was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_service_type
      @room_service_type = RoomServiceType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def room_service_type_params
      params.require(:room_service_type).permit(:name)
    end
end
