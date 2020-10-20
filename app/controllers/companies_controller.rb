class CompaniesController < ApplicationController
  before_action :set_event, only: [:index, :show, :edit, :update, :new, :destroy, :send_message, :assist, :products_and_services] # set @event for these methods to make it available in matching views if available
  before_action :set_company, only: [:show, :edit, :update, :destroy] # set @company ...
  before_action :authenticate_user!, except: [:index] # Devise Authentication
  # GET /companies
  # GET /companies.json
  def index
    authorize Company
    @companies = @event.companies
    .by_title_or_description(params[:search])
    .by_tags(params[:general_tags])
    .by_languages(params[:languages])
    .by_styles(params[:styles])
    .by_countries(params[:countries])
    .order('name')
    @pagy, @companies = pagy(@companies)
  end
  
  # GET /companies/1
  # GET /companies/1.json
  def show
    authorize @company # Company Show policy
    values = @company.ratings.pluck(:value)
    @average_rating = values.inject(&:+).to_f / values.size
    @previous_company = @company.next
    @next_company = @company.previous
    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.build_social
  end

  # GET /companies/1/edit
  def edit
    authorize @company # Company Edit policy
    @company.build_social if @company.social.nil?
  end

  # POST /companies
  # POST /companies.json
  def create
    authorize Company
    @company = Company.new(company_params)
    @event = Event.find(params[:event_id])
    @company.event = @event
    
    respond_to do |format|
      if @company.save

        # TODO: this can be moved to a job, start
        exhibitor_list=[]
        @company.exhibitors.each do |exhibitor|
          password = SecureRandom.uuid
          exhibitor.password = password
          exhibitor_list.push(email: exhibitor.email, password: password)
          exhibitor.save
          CompanyMailer.with(event_id: @event.id, company_id: @company.id, email: exhibitor.email, password: password).new_exhibitor_welcome.deliver_later
        end
         @event.company_exhibitors.update_all(status: "enabled") #if force_enable_company_exhibitors[:force_enable_company_exhibitors].to_i == 1
        CompanyMailer.with(event_id: @event.id, company_id: @company.id, exhibitor_list: exhibitor_list).new_company_email.deliver_later
        # end

        format.html { redirect_to event_company_path(@company.event, @company), notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: event_company_path(@company) }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    authorize @company
    respond_to do |format|
      exhibitors_before = @company.exhibitors.pluck(:id)
      if @company.update(company_params)
        @company.reload
        exhibitors_after = @company.exhibitors.pluck(:id)
        exhibitors_new = exhibitors_after - exhibitors_before
        exhibitors_new = User.where(id: exhibitors_new)
        exhibitors_new.each do |exhibitor|
          password = SecureRandom.uuid
          exhibitor.password = password
          exhibitor.save!
          CompanyMailer.with(event_id: @event.id, company_id: @company.id, email: exhibitor.email, password: password).new_exhibitor_welcome.deliver_later
      end
         CompanyExhibitor.where(user_id: exhibitors_new, company_id: @company.id).update_all(status: 'enabled') #if force_enable_company_exhibitors[:force_enable_company_exhibitors].to_i == 1
        format.html { redirect_to event_company_path(@event, @company), notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: event_company_path(@company) }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    authorize @company
    @event = @company.event
    @company.destroy
    respond_to do |format|
      format.html { redirect_to event_companies_path(@event), notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def send_message
    @company = @event.companies.find(params[:company_id]) 
    CompanyMailer.with(company_id: @company.id, contact_params: contact_params).contact_email.deliver_later

    respond_to do |format|
      format.html { redirect_to event_company_path(@event, @company), notice: 'Message Sent Succesfully!' }
    end
  end

  def rating
    @company = Company.find(params[:company_id]) 
    rating = @company.ratings.where(user: current_user).first_or_initialize
    rating.value = params[:radio1]
    rating.save
end

  def assist
    @company = Company.find(params[:company_id])
    CompanyMailer.with(company_id: @company.id).assist_email.deliver_later
  

    respond_to do |format|
      format.html { redirect_to event_company_path(@event, @company), notice: 'Assist Request Sent Succesfully!' }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_company
      @company = @event.companies.find(params[:id])
    end

    def event_admin_or_site_admin
      current_user.site_admin || @event.event_admins.where(user_id: current_user.id).any?
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:general_tag_list, :fullname, :meeting_link, :meeting_link, :rating, :web_address, :sales_email, :sales_person_name, :tel, :address, :language_list, :country_list, :gallery_exhibitor, :video_exhibitor, :introduction, :name, :description_text, :event_id, :avatar, :flipcard_banner, :email, :phone, :banner, :products_and_services, :about_exhibitor, :enabled, :chatra_id,
      exhibitors_attributes: [:id, :name, :fullname, :last_name, :email, :country, :phone, :password, :avatar, :_destroy], 
      videos_attributes: [:id, :title, :description, :path, :_destroy], 
      staff_members_attributes: [:id, :name, :email, :phone, :address, :_destroy], 
      attachments_attributes: [:id, :title, :description, :reference, :attachment, :_destroy],
      page_items_attributes: [:id, :title, :title_secondary, :description, :image, :_destroy],
      social_attributes: [:id, :linkedin_url, :facebook_url, :twitter_url, :instagram_url],
      information_blocks_attributes: [:id, :title, :description, :about, :image, :link, :_destroy], style_list: [], language_list: [], country_list: [], general_tag_list: [])
    end

    def force_enable_company_exhibitors
      params.require(:company).permit(:force_enable_company_exhibitors)
    end

    def contact_params
      params.permit(:first_name, :last_name, :contact_number, :email, :topic, :message, :event_id, :company_id, :description, :title)
    end
end
