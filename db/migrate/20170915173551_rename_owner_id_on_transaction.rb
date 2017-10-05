class RenameOwnerIdOnTransaction < ActiveRecord::Migration
  def change
    rename_column :transactions, :owner_id, :creator_id
  end
end
