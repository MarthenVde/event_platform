class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :join, :about, :contact, :faq, :terms_and_conditions, :presentations, :workshops, :gallery, :who_should_attend]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
 
    authorize Event
    if params[:search]
      @events = Event.where("name ILIKE ?", "%#{params[:search]}%")
                     .or(Event.where("description ILIKE ?", "%#{params[:search]}%"))
    else
      @events = Event.all
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    authorize @event
    @companies = @event.companies.where(featured: true).order('name') if @event.show_featured_companies
    if DateTime.now < @event.starts_at || !current_user
      @videos = @event.videos.where(video_type: "before_event")
    elsif DateTime.now >= @event.starts_at && DateTime.now <= @event.ends_at && current_user
      @videos = @event.videos.where(video_type: "during_event")
    elsif DateTime.now > @event.ends_at && current_user
      @videos = @event.videos.where(video_type: "after_event")
    else
      @videos = []
    end
  end


  # GET /events/new
  def new
    authorize Event
    @event = Event.new
    @event.build_social
    @event.build_mail_setting
  end

  # GET /events/1/edit
  def edit
    authorize @event
    @event.build_social if @event.social.nil?
    @event.build_mail_setting if  @event.mail_setting.nil?
  end


  # POST /events
  # POST /events.json
  def create
    authorize Event
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        WorkshopsZoomCreateJob.perform_later(@event.id)

        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    authorize @event
    respond_to do |format|
      if @event.update(event_params)
        WorkshopsZoomUpdateJob.perform_later(@event.id)
        format.html { redirect_to edit_event_path(@event), notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    authorize @event
    # destroy @event.presentations.each ... each ....delete zoom_config.meeting_id via method
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    EventAttendee.create(event: @event, user: current_user)
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Successfully joined' }
      format.js
    end
  end

  def about
  end

  def terms_and_conditions
  end

  def faq
  end

  def contact
  end

  def gallery
  end

  def who_should_attend
  end

  def send_message
    set_event # set @event
    EventMailer.with(event: @event, contact_params: contact_params).contact_email.deliver_later

    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: 'Message Sent Succesfully!' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:show_featured_companies, :chatra_id, :meeting_link, :info_desk, :who_should_attend, :pdf_program, :expo_program, :apply_faq_exhibitor, :prospectus_document, :information_blocks, :exhibit_application_form, :apply_to_exhibit, :email, :banner_text_short, :phone, :workshop_image, :presentation_image, :exhibitor_image, :who_should_attend_image, :home_page_data, :introduction, :about, :terms_and_conditions, :description, :faq, :faq_exhibitor, :title, :starts_at, :ends_at, :avatar, :banner, :name,
      videos_attributes: [:id, :path, :title, :description, :video_type, :_destroy],
      attachments_attributes: [:id, :title, :description, :reference, :attachment, :_destroy],
      advertisements_attributes: [:id, :title, :description, :reference, :image, :_destroy],
      sponsors_attributes: [:id, :title, :description, :image, :_destroy],
      page_items_attributes: [:id, :title, :title_secondary, :description, :image, :_destroy],
      companies_attributes: [:id, :featured, :_destroy],
      workshops_attributes: [:id, :title, :enter_workshop, :facilitator, :about, :workshop_facilitator_info, :first_name, :last_name, :description, :starts_at, :ends_at, :avatar, :banner, :about, :zoom_user_id, :_destroy,
      :workshop_presenters_attributes => [:id, :company_exhibitor_id, :_destroy], information_blocks_attributes: [:id, :title, :description, :about, :image, :link, :_destroy]],
      user_description_selects_attributes: [:id, :value, :_destroy],
      image_buttons_attributes: [:id, :title, :image, :link, :_destroy],
      social_attributes: [:id, :linkedin_url, :facebook_url, :twitter_url, :instagram_url],
      mail_setting_attributes: [:id, :email, :password, :address, :port, :starttls_auto],
      presentations_attributes: [:id, :title, :presentation_type, :name, :surname, :presentation_presenter_info, :presentation_info_block, :description, :avatar, :banner, :about, :_destroy, style: [],
      :videos_attributes => [:id, :title, :description, :path, :_destroy], information_blocks_attributes: [:id, :title, :description, :about, :image, :link, :_destroy]])
    end

    def contact_params
      params.permit(:first_name, :last_name, :contact_number, :email, :topic, :message)
    end
end

