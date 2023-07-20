class BedsController < ApplicationController
  before_action :set_bed, only: [:show, :edit, :update, :destroy]

  # GET /beds
  def index
    @beds = Bed.all
  end

  # GET /beds/1
  def show
  end

  # GET /beds/new
  def new
    @bed = Bed.new
  end

  # GET /beds/1/edit
  def edit
  end

  # POST /beds
  def create
    @bed = Bed.new(bed_params)

    if @bed.save
      redirect_to @bed, notice: 'Bed was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /beds/1
  def update
    if @bed.update(bed_params)
      redirect_to @bed, notice: 'Bed was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /beds/1
  def destroy
    @bed.destroy
    redirect_to beds_url, notice: 'Bed was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bed
      @bed = Bed.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bed_params
      params.require(:bed).permit(:bed_number, :bed_type, :room_id, :service_id)
    end
end
