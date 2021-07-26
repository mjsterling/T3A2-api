class BookingsController < ApplicationController
  def index
    @booking = Booking.all
    @booking = @booking.map do |booking|
      bookingObj = { **booking.as_json, room_number: booking.room.number }
    end
    render json: @booking, status: 200
  end

  def show
    @booking = Booking.find(params[:id])
    head 404 and return if @booking == nil
    render json: { **@booking.as_json, room_number: @booking.room.number }, status: 200
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.dates = parse_dates params[:booking][:dates]
    @booking.room = Room.find_by number: params[:booking][:room_number]
    if @booking.save!
      render json: @booking, status: 201
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  def update
    @booking = Booking.find(params[:id])
    head 404 and return if @booking == nil
    @booking.dates = parse_dates params[:booking][:dates]
    head 204 and return if @booking.update(booking_params)

    render json: @booking.errors, status: :unprocessable_entity
  end

  def delete
    begin
      @booking = Booking.find(params[:id])
    rescue
      head 404 and return
    end
    head 204 and return if @booking.destroy!
    render json: @booking.errors
  end

  private

  def booking_params
    params.require(:booking).permit(:first_name, :last_name, :email_address, :phone_number, :num_adults, :num_children, :num_dogs, :dates, request_ids: [])
  end
end
