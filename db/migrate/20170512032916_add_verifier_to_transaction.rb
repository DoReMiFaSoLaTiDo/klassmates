class AddVerifierToTransaction < ActiveRecord::Migration
  def change
    remove_column :transactions, :verifier_id, :string
    add_reference :transactions, :verifier
    rename_column :transactions, :user_id, :owner_id
  end
end
