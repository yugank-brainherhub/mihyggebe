class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bookings/1
  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Booking was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bookings/1
  def destroy
    @booking.destroy
    redirect_to bookings_url, notice: 'Booking was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def booking_params
      params.require(:booking).permit(:first_name, :last_name, :email, :mobile, :user_id, :bookingID, :price_includes, :price_per_bed, :other_relation, :cancelled_at, :checkin, :checkout, :arrival_time, :no_of_guests, :doc_received, :status, :care_id)
    end
end
