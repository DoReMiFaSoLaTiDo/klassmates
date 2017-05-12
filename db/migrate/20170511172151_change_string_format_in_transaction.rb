class ChangeStringFormatInTransaction < ActiveRecord::Migration
  def up
    remove_column :transactions, :tran_type, :string
    add_column :transactions, :tran_type, :integer
    remove_column :transactions, :is_verified
    add_column :transactions, :status, :integer
  end

  def down
    change_column :transactions, :tran_type, :string
    remove_column :transactions, :status
    add_column :transactions, :is_verified, :boolean
  end
end
