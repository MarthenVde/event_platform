class MailSetting < ApplicationRecord
  belongs_to :composite, polymorphic: true
  validates :address, presence: true
  validates :password, presence: true
  validates :port, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  length: { maximum: 105, minimum: 6 },
  format: { with: VALID_EMAIL_REGEX } 
end
