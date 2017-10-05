class AddNarrationToTransaction < ActiveRecord::Migration
  def up
    add_column :transactions, :description, :string
  end

  def down
    remove_column :transactions, description, :string
  end
end
