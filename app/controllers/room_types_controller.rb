class RoomTypesController < ApplicationController
  before_action :set_room_type, only: [:show, :edit, :update, :destroy]

  # GET /room_types
  def index
    @room_types = RoomType.all
  end

  # GET /room_types/1
  def show
  end

  # GET /room_types/new
  def new
    @room_type = RoomType.new
  end

  # GET /room_types/1/edit
  def edit
  end

  # POST /room_types
  def create
    @room_type = RoomType.new(room_type_params)

    if @room_type.save
      redirect_to @room_type, notice: 'Room type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /room_types/1
  def update
    if @room_type.update(room_type_params)
      redirect_to @room_type, notice: 'Room type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /room_types/1
  def destroy
    @room_type.destroy
    redirect_to room_types_url, notice: 'Room type was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_type
      @room_type = RoomType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def room_type_params
      params.require(:room_type).permit(:name)
    end
end
