class WorkshopPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.present? && (record.event.event_attendees.where(user_id: user.id, status: 'enabled').any? || record.event.company_exhibitors.where(user_id: user.id, status: 'enabled').any? || user.site_admin.present? || record.event.event_admins.where(user_id: user.id, status: 'enabled').any?)
  end
end
