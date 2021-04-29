class PresentationsController < ApplicationController
  include Pundit
  before_action :set_event, only: [:index, :show]
  before_action :set_presentation, only: [:show]
  before_action :authenticate_user!, except: [:index]


  def index
    authorize Presentation
    @featured_presentations = @event.presentations.where(presentation_type: 'featured').order("updated_at DESC")
    @webcam_presentations = @event.presentations.where(presentation_type: 'webcam').order("updated_at DESC")
    @speaker_presentations = @event.presentations.where(presentation_type: 'speaker').order("updated_at DESC")
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    
    authorize @presentation
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_presentation
      @presentation = @event.presentations.find(params[:id])
    end

end
