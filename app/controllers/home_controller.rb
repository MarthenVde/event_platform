class HomeController < ApplicationController
  def index
    
  end

  def default_event
    redirect_to  event_path(Event.first)
  end
end