class ZoomConfig < ApplicationRecord
  belongs_to :composite, polymorphic: true
end
