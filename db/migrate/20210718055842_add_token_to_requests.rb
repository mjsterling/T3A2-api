class AddTokenToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :token, :string
    add_reference :bookings, :request, index: true
  end
end
