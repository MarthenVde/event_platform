class Sponsor < ApplicationRecord
  belongs_to :event
  has_one_attached :image, dependent: :destroy
end
