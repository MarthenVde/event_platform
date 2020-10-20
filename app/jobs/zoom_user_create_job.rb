class ZoomUserCreateJob < ApplicationJob
  queue_as :default

  def perform(zoom_user_id)
    @zoom_user = ZoomUser.find(zoom_user_id)
    return unless @zoom_user
    zoom_client = Zoom.new
    zoom_user = zoom_client.user_create(email: @zoom_user.email, first_name: @zoom_user.first_name, last_name: @zoom_user.last_name, type: @zoom_user.user_type, action: 'create')
    @zoom_user.update(zoom_user_id: zoom_user['id'])
  end
end
