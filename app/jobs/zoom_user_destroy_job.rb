class ZoomUserDestroyJob < ApplicationJob
  queue_as :default

  def perform(zoom_user_id)
    zoom_client = Zoom.new
    zoom_client.user_delete(id: zoom_user_id)
  end
end
