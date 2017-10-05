class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :transactions, foreign_key: :creator_id
  has_one :contribution #, through: :transactions
  has_one :profile, dependent: :destroy

  # enum role: { "Admin": 1, "Advocate": 2, "Strategist": 3, "Member": 4 }

  accepts_nested_attributes_for :profile

  has_many :verified_transactions, class_name: :transactions, foreign_key: :verifier_id

  validates :email, presence: true
  validates :phone, presence: true
  validates :auth_token, uniqueness: true

  before_create :generate_authentication_token!
  after_create  :set_role, :create_contribution
  # after_create :build_profile
  #
  # def build_profile
  #   Profile.create(user: self, status: :inactive, name: self.name) # Associations must be defined correctly for this syntax, avoids using ID's directly.
  # end

  def phone=(value)
    super(value.blank? ? nil : value.gsub(/[^\w\s]/, ''))
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  def contribution_lcy
    return self.contribution.balance_lcy if self.contribution && self.contribution.balance_lcy.present?
    create_contribution
  end

  def contribution_fcy
    return self.contribution.balance_fcy if self.contribution && self.contribution.balance_fcy.present?
    create_contribution
  end

  def create_contribution
    self.build_contribution.update_attributes({user_id: self.id, balance_lcy: 0, balance_fcy: 0})
  end

  def set_role
    self.role_id = Role.find_by(name: 'Member').id
  end


  delegate :name, to: :profile, prefix: true
  delegate :status, to: :profile, prefix: true
  delegate :balance_lcy, to: :contribution, prefix: true
  delegate :balance_fcy, to: :contribution, prefix: true
end
