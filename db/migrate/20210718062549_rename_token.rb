class RenameToken < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :token
    add_column :requests, :reference_number, :string
  end
end
