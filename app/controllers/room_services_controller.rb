class RoomServicesController < ApplicationController
  before_action :set_room_service, only: [:show, :edit, :update, :destroy]

  # GET /room_services
  def index
    @room_services = RoomService.all
  end

  # GET /room_services/1
  def show
  end

  # GET /room_services/new
  def new
    @room_service = RoomService.new
  end

  # GET /room_services/1/edit
  def edit
  end

  # POST /room_services
  def create
    @room_service = RoomService.new(room_service_params)

    if @room_service.save
      redirect_to @room_service, notice: 'Room service was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /room_services/1
  def update
    if @room_service.update(room_service_params)
      redirect_to @room_service, notice: 'Room service was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /room_services/1
  def destroy
    @room_service.destroy
    redirect_to room_services_url, notice: 'Room service was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_service
      @room_service = RoomService.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def room_service_params
      params.require(:room_service).permit(:name, :room_service_type_id)
    end
end
