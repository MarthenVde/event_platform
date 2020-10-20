class CompanyExhibitor < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_one :exhibitor, through: :user
  
  validates :company, uniqueness: { scope: :user }
  
  # accepts_nested_attributes_for :user
  # attr_accessor :user_attributes

  def company_exhibitor_name
    "#{user.name} #{user.last_name}"
  end

end
