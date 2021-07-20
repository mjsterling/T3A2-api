class AddRoomNumberToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :number, :bigint
  end
end
