class RoomsController < ApplicationController
  def index
    @room = Room.all
    @room = @room.map do |room|
      room_object = {
        **room.as_json,
        bookings: room.bookings.as_json,
      }
    end
    render json: @room, status: 200
  end

  def show
    @room = Room.find params[:id]
    render json: @room, status: 200
  end

  def create
    @room = Room.new room_params
    if @room.save!
      render json: @room, status: 201
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def update
    @room = Room.find params[:id]
    head 204 and return if @room.update(room_params)
    render json: @room.errors, status: :unprocessable_entity
  end

  private

  def room_params
    params.require(:room).permit(:number, :capacity, :peak_rate, :offpeak_rate, booking_ids: [])
  end
end
