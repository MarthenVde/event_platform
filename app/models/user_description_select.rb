class UserDescriptionSelect < ApplicationRecord
  belongs_to :composite, polymorphic: true
end
