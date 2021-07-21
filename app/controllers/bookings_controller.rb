class BookingsController < ApplicationController
  def index
    @booking = Booking.all
    render json: @booking, status: 200
  end

  def show
    @booking = Booking.find(params[:id])
    render json: @booking, status: 200
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.dates = params[:booking][:dates].map { |date| Date.parse(date) }.uniq
    @booking.room = Room.find_by number: params[:booking][:room_number]
    if @booking.save!
      render json: @booking, status: 201
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.dates = params[:booking][:dates].map { |date| Date.parse(date) }.uniq if params[:booking][:dates]
    head 204 and return if @booking.update(booking_params)

    render json: @booking.errors, status: :unprocessable_entity
  end

  private

  def booking_params
    params.require(:booking).permit(:first_name, :last_name, :email_address, :phone_number, :num_adults, :num_children, :num_dogs, :dates, request_ids: [])
  end
end
