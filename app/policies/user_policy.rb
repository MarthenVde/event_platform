class UserPolicy < ApplicationPolicy
  def index?
    user.present? && user.site_admin.present?
  end

  def show?
    user.present? && (record.id == user.id || user.site_admin.present?)
  end

  def create?
    user.present? && (user.site_admin.present?)
  end

  def update?
    user.present? && (user.site_admin.present?)
  end
end
