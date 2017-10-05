class AddTypeToContribution < ActiveRecord::Migration
  def change
    remove_column :contributions, :balance_lcy
    remove_column :contributions, :balance_fcy
    add_column :contributions, :naira_balance, :decimal, precision: 13, scale: 2
    add_column :contributions, :us_dollar_balance, :decimal, precision: 13, scale: 2
    add_column :contributions, :gb_pound_balance, :decimal, precision: 13, scale: 2
  end
end
