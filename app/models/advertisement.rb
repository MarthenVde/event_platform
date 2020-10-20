class Advertisement < ApplicationRecord
  belongs_to :composite, polymorphic: true
  has_one_attached :image, dependent: :destroy
end
