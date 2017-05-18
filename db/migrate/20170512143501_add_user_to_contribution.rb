class AddUserToContribution < ActiveRecord::Migration
  def change
    add_reference :contributions, :user, index: true, foreign_key: true
    rename_column :contributions, :amount_lcy, :balance_lcy
    rename_column :contributions, :amount_fcy, :balance_fcy
  end
end
