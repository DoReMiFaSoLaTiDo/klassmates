class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :contribution

  # belongs_to :owner, class_name: :user
  # belongs_to :verifier, class_name: :user

  before_update :prevent_update, if: Proc.new{ |transaction| Transaction.find(self[:id]).verified? }
  around_update :update_account_balance, if: Proc.new{ |transaction| transaction.verified? }


  validates :amount, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
  validates :currency, presence: true

  validate :insufficient_funds, on: [:create, :update]
  validate :verifier_is_different_from_owner, on: [:create, :update]


  enum tran_type: { credit: 0, debit: 1 }
  enum status: { unverified: 0, verified: 1, deleted: 2  }
  enum currency: { "Nigerian Naira": 0, "US Dollar": 1 }

  private
    def verifier_is_different_from_owner
      errors.add(:verifier_id, "Owner cannot verify own transaction") if self.owner_id.eql? self.verifier_id
    end

    def prevent_update_on_verified_transactions
      errors.add(:owner_id, "Previously verified transaction cannot be updated")
    end

    def update_account_balance
      acct = Contribution.find(self.contribution_id)
      if self.currency.eql? "Nigerian Naira"
        if self.credit?
          acct[:balance_lcy] += self.amount
        else
          acct[:balance_lcy] -= self.amount
        end
        Contribution.find(self.contribution_id).update_attribute(:balance_lcy, acct[:balance_lcy])
      else
        if self.credit?
          acct[:balance_fcy] += self.amount
        else
          acct[:balance_fcy] -= self.amount
        end
        Contribution.find(self.contribution_id).update_attribute(:balance_fcy, acct[:balance_fcy])
      end
    end

    def insufficient_funds
      return true if self.credit?
      if self.currency.eql? "Nigerian Naira"
        account_balance = Contribution.find(self[:contribution_id]).balance_lcy
      else
        account_balance = Contribution.find(self[:contribution_id]).balance_fcy
      end
      errors.add(:amount, "Insufficient funds") if account_balance < self.amount
    end

    def sufficient_funds_check
      if self.currency.eql? "Nigerian Naira"
        account_balance = Contribution.find(params[:contribution_id]).balance_lcy
      else
        account_balance = Contribution.find(params[:contribution_id]).balance_fcy
      end
      return false if account_balance < self.amount
      true
    end

end
