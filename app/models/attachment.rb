class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true
  has_one_attached :attachment

  validates :attachment, presence: true, 
    presence: true, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 0..3.megabytes }
end
