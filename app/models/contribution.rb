class Contribution < ActiveRecord::Base
  has_many :transactions
  has_one :user, through: :transactions
end
