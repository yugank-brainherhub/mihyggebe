class ProviderSupportsController < ApplicationController
  before_action :set_provider_support, only: [:show, :edit, :update, :destroy]

  # GET /provider_supports
  def index
    @provider_supports = ProviderSupport.all
  end

  # GET /provider_supports/1
  def show
  end

  # GET /provider_supports/new
  def new
    @provider_support = ProviderSupport.new
  end

  # GET /provider_supports/1/edit
  def edit
  end

  # POST /provider_supports
  def create
    @provider_support = ProviderSupport.new(provider_support_params)

    if @provider_support.save
      redirect_to @provider_support, notice: 'Provider support was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /provider_supports/1
  def update
    if @provider_support.update(provider_support_params)
      redirect_to @provider_support, notice: 'Provider support was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /provider_supports/1
  def destroy
    @provider_support.destroy
    redirect_to provider_supports_url, notice: 'Provider support was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider_support
      @provider_support = ProviderSupport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def provider_support_params
      params.require(:provider_support).permit(:name, :contact_type, :active, :user_id, :phone_number, :email)
    end
end
