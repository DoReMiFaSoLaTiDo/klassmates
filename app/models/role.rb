class Role < ActiveRecord::Base
  has_many :users

  validates :name, presence: true
  validates :description, presence: true
end
