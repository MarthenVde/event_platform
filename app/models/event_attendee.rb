class EventAttendee < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :event, uniqueness: { scope: :user }
  before_save :enable_attendee

  def enable_attendee
    self.status = "enabled"
  end

end
