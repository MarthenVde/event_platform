class Video < ApplicationRecord
  belongs_to :composite, polymorphic: true
end
