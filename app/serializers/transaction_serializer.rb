class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :currency, :status

  belongs_to :contribution
end
