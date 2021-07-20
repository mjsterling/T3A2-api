class ChangeDatesToArrays2 < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :dates
    remove_column :bookings, :dates
    add_column :bookings, :dates, :date, array: true, default: []
    add_column :requests, :dates, :date, array: true, default: []
  end
end
