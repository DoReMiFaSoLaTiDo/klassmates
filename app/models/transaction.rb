class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :contribution

  # belongs_to :owner, class_name: :user
  # belongs_to :verifier, class_name: :user

  validates :amount, presence: true

  enum tran_type: { credit: 0, debit: 1 }
  enum status: { unverified: 0, verified: 1, deleted: 2  }
  enum currency: { "Nigerian Naira": 0, "US Dollar": 1 }
end
