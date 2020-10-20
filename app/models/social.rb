class Social < ApplicationRecord
  belongs_to :composite, polymorphic: true
  validates :facebook_url, :instagram_url, :twitter_url, :linkedin_url, url: { allow_blank: true }
end
