class CompanyChannel < ApplicationCable::Channel
  def connect
      self.current_user = User.first
  end

  def subscribed
    puts "dynamic id is ----- #{params[:roomId]}"
    #stream_from "room_channel_#{params[:roomId]}"
    #stream_from "company_1"
  end

  def subscribe(data)
    puts "dynamic roomId is ----- #{data['roomId']}"
    stream_from "company_#{data['roomId']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
