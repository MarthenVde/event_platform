class User < ApplicationRecord
  has_many :company_exhibitors, dependent: :destroy
  has_many :event_attendees, dependent: :destroy
  has_many :event_admins, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  has_one :site_admin , dependent: :destroy
  accepts_nested_attributes_for :company_exhibitors, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :event_attendees, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :event_admins, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :site_admin, allow_destroy: true
 
  scope :by_name_last_name_or_email_phone, ->(search) { where("name ILIKE ?", "%#{search}%").or(where("last_name ILIKE ?", "%#{search}%").or(where("email ILIKE ?", "%#{search}%").or(where("phone ILIKE ?", "%#{search}%")))) if search.present? }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :randomize_password

  def randomize_password
    self.password = SecureRandom.uuid unless persisted? || self.password.present? #this will anyways be overwritten
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
  length: { maximum: 105, minimum: 6 },
  format: { with: VALID_EMAIL_REGEX } 

  validates :name, presence: true
  validates :last_name, presence: true
  #validates :country, presence: true

  def part_of_event?(event)
    #current_user.part_of_event?(event) -> true of false
    event.attendees.where(id: id).any? || event.exhibitors.where(id: id).any? || site_admin.present?
  end

  def can_manage_event?(event)
    event.event_admins.where(user_id: id).any? || site_admin.present?
  end

  def full_name
    "#{name} #{last_name}"
  end


end

#
#Regex code
#
#
# validates :username, presence: true, 
# uniqueness: { case_sensitive: false }, 
# length: { minimum: 3, maximum: 25 }
# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
# validates :email, presence: true, 
# uniqueness: { case_sensitive: false }, 
# length: { maximum: 105 },
# format: { with: VALID_EMAIL_REGEX }