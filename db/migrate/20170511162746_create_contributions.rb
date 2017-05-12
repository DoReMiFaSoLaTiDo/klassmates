class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.decimal :amount_lcy, precision: 13, scale: 2
      t.decimal :amount_fcy, precision: 13, scale: 2

      t.timestamps null: false
    end
  end
end
