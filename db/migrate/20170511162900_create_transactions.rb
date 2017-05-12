class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :tran_type
      t.decimal :amount, precision: 13, scale: 2
      t.integer :currency
      t.boolean :is_verified
      t.string :verifier_id
      t.references :user, index: true, foreign_key: true
      t.references :contribution, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
