class MihyggeSupportsController < ApplicationController
  before_action :set_mihygge_support, only: [:show, :edit, :update, :destroy]

  # GET /mihygge_supports
  def index
    @mihygge_supports = MihyggeSupport.all
  end

  # GET /mihygge_supports/1
  def show
  end

  # GET /mihygge_supports/new
  def new
    @mihygge_support = MihyggeSupport.new
  end

  # GET /mihygge_supports/1/edit
  def edit
  end

  # POST /mihygge_supports
  def create
    @mihygge_support = MihyggeSupport.new(mihygge_support_params)

    if @mihygge_support.save
      redirect_to @mihygge_support, notice: 'Mihygge support was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /mihygge_supports/1
  def update
    if @mihygge_support.update(mihygge_support_params)
      redirect_to @mihygge_support, notice: 'Mihygge support was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /mihygge_supports/1
  def destroy
    @mihygge_support.destroy
    redirect_to mihygge_supports_url, notice: 'Mihygge support was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mihygge_support
      @mihygge_support = MihyggeSupport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mihygge_support_params
      params.require(:mihygge_support).permit(:support_type, :description, :file_1, :user_id, :email, :phone_number, :first_name, :last_name, :support_number, :is_provider, :provider_id)
    end
end
