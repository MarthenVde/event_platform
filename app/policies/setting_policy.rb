class SettingPolicy < ApplicationPolicy
  def index?
    user.present? && (user.site_admin.present?)
  end

  def create?
    user.present? && (user.site_admin.present?)
  end

end
