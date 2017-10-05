class Profile < ActiveRecord::Base
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates_format_of :name, :with => /\A(?=.* )[^0-9`!@#\\\$%\^&*\;+_=]{4,}\z/
  validates :status, presence: true

  enum status: { inactive: 0, activated: 1, deactivated: 2  }
  delegate :phone, to: :user, prefix: true
  delegate :contribution_lcy, to: :user
  delegate :contribution_fcy, to: :user
end
