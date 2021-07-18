class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.bigint :capacity
      t.bigint :offpeak_rate
      t.bigint :peak_rate

      t.timestamps
    end
  end
end
