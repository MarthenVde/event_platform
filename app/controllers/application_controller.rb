class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit
  protect_from_forgery with: :exception, prepend: true
  before_action :set_logo
  before_action :set_banner
  before_action :set_prospectus_document
  before_action :set_expo_program
  before_action :set_exhibit_application_form
  
  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    sign_out current_user # method that will destroy the user cookies
    redirect_to sign_in_create_event_path(Event.find(params[:id])), notice: 'Something went wrong. Please try signing in again'
  end

  private

  def set_logo
    @logo ||= Setting.find_by(var: "logo")&.file
  end

  def set_banner
    @banner ||= Setting.find_by(var: "banner")&.file
  end

  def set_prospectus_document
    @prospectus_document  ||= Setting.find_by(var: "prospectus_document")&.file
  end

  def set_expo_program
    @expo_program ||= Setting.find_by(var: "expo_program")&.file
  end

  def set_exhibit_application_form
    @exhibit_application_form  ||= Setting.find_by(var: "exhibit_application_form")&.file
  end

end

