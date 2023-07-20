class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :edit, :update, :destroy]

  # GET /facilities
  def index
    @facilities = Facility.all
  end

  # GET /facilities/1
  def show
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
  end

  # GET /facilities/1/edit
  def edit
  end

  # POST /facilities
  def create
    @facility = Facility.new(facility_params)

    if @facility.save
      redirect_to @facility, notice: 'Facility was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /facilities/1
  def update
    if @facility.update(facility_params)
      redirect_to @facility, notice: 'Facility was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /facilities/1
  def destroy
    @facility.destroy
    redirect_to facilities_url, notice: 'Facility was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def facility_params
      params.require(:facility).permit(:name, :facility_type_id)
    end
end
