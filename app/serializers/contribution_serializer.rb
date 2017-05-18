class ContributionSerializer < ActiveModel::Serializer
  attributes :id, :balance_lcy, :balance_fcy

  has_many :transactions
end
