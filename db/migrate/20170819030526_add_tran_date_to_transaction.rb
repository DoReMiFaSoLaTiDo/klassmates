class AddTranDateToTransaction < ActiveRecord::Migration
  def up
    add_column :transactions, :tran_date, :date
  end

  def down
    remove_column :transactions, :tran_date, :date
  end
end
