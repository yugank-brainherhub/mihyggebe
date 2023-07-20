class StaffDetailsController < ApplicationController
  before_action :set_staff_detail, only: [:show, :edit, :update, :destroy]

  # GET /staff_details
  def index
    @staff_details = StaffDetail.all
  end

  # GET /staff_details/1
  def show
  end

  # GET /staff_details/new
  def new
    @staff_detail = StaffDetail.new
  end

  # GET /staff_details/1/edit
  def edit
  end

  # POST /staff_details
  def create
    @staff_detail = StaffDetail.new(staff_detail_params)

    if @staff_detail.save
      redirect_to @staff_detail, notice: 'Staff detail was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /staff_details/1
  def update
    if @staff_detail.update(staff_detail_params)
      redirect_to @staff_detail, notice: 'Staff detail was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /staff_details/1
  def destroy
    @staff_detail.destroy
    redirect_to staff_details_url, notice: 'Staff detail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff_detail
      @staff_detail = StaffDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def staff_detail_params
      params.require(:staff_detail).permit(:name, :staff_role_id, :care_id)
    end
end
