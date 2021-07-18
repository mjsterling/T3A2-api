class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :phone_number
      t.bigint :num_adults
      t.bigint :num_children
      t.bigint :num_dogs
      t.string :dates
      t.boolean :archived

      t.timestamps
    end
  end
end
