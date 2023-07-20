class StaffRolesController < ApplicationController
  before_action :set_staff_role, only: [:show, :edit, :update, :destroy]

  # GET /staff_roles
  def index
    @staff_roles = StaffRole.all
  end

  # GET /staff_roles/1
  def show
  end

  # GET /staff_roles/new
  def new
    @staff_role = StaffRole.new
  end

  # GET /staff_roles/1/edit
  def edit
  end

  # POST /staff_roles
  def create
    @staff_role = StaffRole.new(staff_role_params)

    if @staff_role.save
      redirect_to @staff_role, notice: 'Staff role was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /staff_roles/1
  def update
    if @staff_role.update(staff_role_params)
      redirect_to @staff_role, notice: 'Staff role was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /staff_roles/1
  def destroy
    @staff_role.destroy
    redirect_to staff_roles_url, notice: 'Staff role was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff_role
      @staff_role = StaffRole.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def staff_role_params
      params.require(:staff_role).permit(:name)
    end
end
