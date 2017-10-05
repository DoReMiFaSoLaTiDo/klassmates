class Contribution < ActiveRecord::Base
  has_many :transactions, as: :tranable
  belongs_to :user

  self.inheritance_column = :currency

  def self.currencies
    %w(Naira UsDollar GbPound)
  end

  scope :naira, -> { where(currency: 'Naira') }
  scope :us_dollar, -> { where(currency: 'UsDollar') }
  scope :gb_pound, -> { where(currency: 'GbPound') }
end
