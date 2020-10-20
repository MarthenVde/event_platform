class WorkshopsController < ApplicationController
  include Pundit
  before_action :set_event, only: [:index, :show]
  before_action :set_workshop, only: [:show]
  before_action :authenticate_user!, except: [:index]

  
  def index
    authorize Workshop
    @workshops = @event.workshops.order('starts_at').group_by{|x| x.starts_at.strftime("%Y-%m-%d")}
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    authorize @workshop
    values = @workshop.ratings.pluck(:value)
    @average_rating = values.inject(&:+).to_f / values.size
    respond_to do |format|
      format.html
      format.json
    end
  end

  def rating
    @workshop = Workshop.find(params[:workshop_id]) 
    rating = @workshop.ratings.where(user: current_user).first_or_initialize
    rating.value = params[:radio1]
    rating.save
  end

  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_workshop
      @workshop = @event.workshops.find(params[:id])
    end
end
