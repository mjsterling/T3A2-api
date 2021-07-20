class BookingsController < ApplicationController

  def index
    @booking = Booking.all
    pp @booking
    render json: @booking, status: 200
  end

  def show
    @booking = Booking.find(params[:id])
    render json: @booking, status: 200
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save!
      render json: @booking, status: 201
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      head 204 and return
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:first_name, :last_name, :email_address, :phone_number, :num_adults, :num_children, :num_dogs, :dates, request_ids: [])
  end

end
