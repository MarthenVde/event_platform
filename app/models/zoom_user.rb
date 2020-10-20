class ZoomUser < ApplicationRecord
  has_many :workshops, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  length: { maximum: 105, minimum: 6 },
  format: { with: VALID_EMAIL_REGEX } 
  validates :first_name, :last_name, :user_type, presence: true
  def zoom_user_description
    "#{email}: #{first_name} #{last_name}"
  end
end
