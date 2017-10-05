class CreateCooperativePools < ActiveRecord::Migration
  def change
    create_table :cooperative_accounts do |t|
      t.string :account_name
      t.string :account_type
      t.decimal :naira_balance, precision: 13, scale: 2
      t.decimal :usd_balance, precision: 13, scale: 2
      t.decimal :gbp_balance, precision: 13, scale: 2

      t.timestamps null: false
    end
  end
end
