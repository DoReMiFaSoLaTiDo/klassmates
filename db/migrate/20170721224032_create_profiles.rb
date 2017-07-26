class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :nickname
      t.string :image
      t.date :birthday
      t.text :specialities
      t.text :in_network
      t.text :contact
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
