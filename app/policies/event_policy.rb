class EventPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      true
    end

    def create?
      user.present? && (user.site_admin.present?)
    end

    def update?
      user.present? && (user.site_admin.present? || record.event_admins.where(user_id: user.id, status: 'enabled').any?)
    end

    def create_company?
      user.present? && (user.site_admin.present? || record.event_admins.where(user_id: user.id, status: 'enabled').any?)
    end
end
