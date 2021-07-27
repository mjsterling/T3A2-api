class RemoveArchivedFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :archived
  end
end
