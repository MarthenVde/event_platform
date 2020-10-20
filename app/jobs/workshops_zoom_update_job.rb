class WorkshopsZoomUpdateJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    @event = Event.find(event_id)
    return unless @event

    zoom_client = Zoom.new
    @event.workshops.each do |workshop|
      if workshop.zoom_config.present?
        zoom_client.meeting_update(
        meeting_id: workshop.zoom_config.meeting_id, 
        host_id: workshop.zoom_user.zoom_user_id,
        start_time: workshop.starts_at.strftime("%Y-%m-%dT%H:%M:00"), 
        duration: ((workshop.ends_at - workshop.starts_at)/60).round, 
        topic: workshop.title,
        timezone: "Africa/Harare"
        )
      else
      meeting = zoom_client.meeting_create(
        user_id: workshop.zoom_user.zoom_user_id,
        topic: workshop.title, 
        start_time: workshop.starts_at.strftime("%Y-%m-%dT%H:%M:00"), 
        duration: ((workshop.ends_at - workshop.starts_at)/60).round, 
        timezone: "Africa/Harare",
        )
        workshop.zoom_config = ZoomConfig.new(join_url: meeting['join_url'], start_url: meeting['start_url'], meeting_id: meeting['id'].to_s, host_id: meeting['host_id'] )
      end
    end
  end
end
