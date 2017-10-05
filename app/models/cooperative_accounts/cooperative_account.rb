class CooperativeAccount < ActiveRecord::Base
  has_many :transactions, as: :tranable
  
  self.inheritance_column = :account_type

  def self.account_types
    %w(Donation MemberContribution Expense Revenue)
  end

  scope :donation, -> { where(account_type: 'Donation') }
  scope :expense, -> { where(account_type: 'Expense') }
  scope :member_contribution, -> { where(account_type: 'MemberContribution') }
  scope :revenue, -> { where(account_type: 'Revenue') }
end
