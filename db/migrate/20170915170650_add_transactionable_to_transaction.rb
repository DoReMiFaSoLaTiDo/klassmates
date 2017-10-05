class AddTransactionableToTransaction < ActiveRecord::Migration
  def change
    add_reference :transactions, :tranable, polymorphic: true, index: true
  end
end
