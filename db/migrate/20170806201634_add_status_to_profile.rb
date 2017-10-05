class AddStatusToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :status, :integer, defaults: 0
  end
end
