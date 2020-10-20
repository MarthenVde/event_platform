class Workshop < ApplicationRecord
  belongs_to :event
  has_many :ratings, as: :composite, dependent: :destroy
  has_many :information_blocks, as: :composite, dependent: :destroy
  has_one :zoom_config, as: :composite, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy 
  has_one_attached :banner, dependent: :destroy
  belongs_to :zoom_user
  has_rich_text :about
  has_rich_text :workshop_facilitator_info
  has_rich_text :enter_workshop
  has_many :workshop_presenters
  accepts_nested_attributes_for :workshop_presenters, allow_destroy: true
  accepts_nested_attributes_for :information_blocks, allow_destroy: true
  validates :starts_at, :ends_at, :title, presence: true
  validates :avatar, :banner,
    blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 0..3.megabytes }

end
