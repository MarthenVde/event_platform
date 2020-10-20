class CompanyPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      user.present? && ((record.event.event_attendees.where(user_id: user.id, status: 'enabled').any? && (DateTime.current >= record.event.starts_at && DateTime.current <= record.event.ends_at)) || record.event.company_exhibitors.where(user_id: user.id, status: 'enabled').any? || user.site_admin.present? || record.event.event_admins.where(user_id: user.id, status: 'enabled').any?)
    end

    def create?
      user.present? && (user.site_admin.present? || (record.event.event_admins.where(user_id: user.id, status: 'enabled').any?))
    end

    def update?
      user.present? && ((record.company_exhibitors.where(user_id: user.id, status: 'enabled').any? && (DateTime.current <= record.event.ends_at))  || user.site_admin.present? || record.event.event_admins.where(user_id: user.id, status: 'enabled').any?)
    end
end
