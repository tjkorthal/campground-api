class BookingsController < ApplicationController
  def create
    Booking.transaction do
      @booking = Booking.create!(campsite_id: booking_params[:campsite_id])
      BookedDay.create_for_range(date_range, @booking.id)
    end

    render json: @booking
  end

  def show
    render json: Booking.find(params[:id])
  end

  def update
    Booking.transaction do
      @booking = Booking.find(params[:id])
      @booking.booked_days.destroy_all
      BookedDay.create_for_range(date_range, @booking.id)
      @booking.update(campsite_id: booking_params[:campground_id]) if booking_params[:campground_id].present?
    end

    render json: @booking
  end

  def destroy
    render json: Booking.destroy(params[:id])
  end

  def index
    render json: Booking.all
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :campsite_id)
  end

  def date_range
    Date.parse(booking_params[:start_date])..Date.parse(booking_params[:end_date])
  end
end
