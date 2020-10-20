class Presentation < ApplicationRecord
  belongs_to :event
  has_one_attached :avatar, dependent: :destroy 
  has_one_attached :banner, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :information_blocks, as: :composite, dependent: :destroy
  has_many :videos, as: :composite, dependent: :destroy
  has_rich_text :about
  has_rich_text :presentation_presenter_info
  has_rich_text :presentation_info_block
  has_one :zoom_config, as: :composite, dependent: :destroy
  has_many :presentation_presenters
  accepts_nested_attributes_for :presentation_presenters, allow_destroy: true
  accepts_nested_attributes_for :information_blocks, allow_destroy: true
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank
  validates :avatar, :banner, :image,
    blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 0..3.megabytes }
  validates :presentation_type, presence: true
end
