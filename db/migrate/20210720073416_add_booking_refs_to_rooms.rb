class AddBookingRefsToRooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :bookings, index: true
  end
end
