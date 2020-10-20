class InformationWorkshopBlock < ApplicationRecord
  belongs_to :composite, polymorphic: true
  has_rich_text :about
  has_one_attached :image, dependent: :destroy
end