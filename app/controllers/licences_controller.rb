class LicencesController < ApplicationController
  before_action :set_licence, only: [:show, :edit, :update, :destroy]

  # GET /licences
  def index
    @licences = Licence.all
  end

  # GET /licences/1
  def show
  end

  # GET /licences/new
  def new
    @licence = Licence.new
  end

  # GET /licences/1/edit
  def edit
  end

  # POST /licences
  def create
    @licence = Licence.new(licence_params)

    if @licence.save
      redirect_to @licence, notice: 'Licence was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /licences/1
  def update
    if @licence.update(licence_params)
      redirect_to @licence, notice: 'Licence was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /licences/1
  def destroy
    @licence.destroy
    redirect_to licences_url, notice: 'Licence was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_licence
      @licence = Licence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def licence_params
      params.require(:licence).permit(:name, :licence_type)
    end
end
