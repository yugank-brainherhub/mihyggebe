class FacilityTypesController < ApplicationController
  before_action :set_facility_type, only: [:show, :edit, :update, :destroy]

  # GET /facility_types
  def index
    @facility_types = FacilityType.all
  end

  # GET /facility_types/1
  def show
  end

  # GET /facility_types/new
  def new
    @facility_type = FacilityType.new
  end

  # GET /facility_types/1/edit
  def edit
  end

  # POST /facility_types
  def create
    @facility_type = FacilityType.new(facility_type_params)

    if @facility_type.save
      redirect_to @facility_type, notice: 'Facility type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /facility_types/1
  def update
    if @facility_type.update(facility_type_params)
      redirect_to @facility_type, notice: 'Facility type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /facility_types/1
  def destroy
    @facility_type.destroy
    redirect_to facility_types_url, notice: 'Facility type was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility_type
      @facility_type = FacilityType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def facility_type_params
      params.require(:facility_type).permit(:name)
    end
end
