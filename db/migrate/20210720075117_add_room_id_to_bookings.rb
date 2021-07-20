class AddRoomIdToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :room_id, :bigint
  end
end
