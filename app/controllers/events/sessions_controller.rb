# frozen_string_literal: true

class Events::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :verify_authenticity_token, :only => [:create]
  before_action :set_event
  # GET /resource/sign_in
  def new
    sign_out current_user if current_user
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected
    def set_event
      @event = Event.find(params[:id])
    end

    def after_sign_in_path_for(resource_or_scope)
      if DateTime.now < @event.starts_at
        set_flash_message!(:notice, :before_event_message, event_name: @event.name, starts_at_date: @event.starts_at.strftime("%a %d %B %Y"), ends_at_date: @event.ends_at.strftime("%a %d %B %Y"), starts_at_time: @event.starts_at.strftime("%H:%M"), ends_at_time: @event.ends_at.strftime("%H:%M"))
      elsif DateTime.now > @event.ends_at
       set_flash_message!(:notice, :after_event_message, event_name: @event.name, starts_at_date: @event.starts_at.strftime("%a %d %B %Y"), ends_at_date: @event.ends_at.strftime("%a %d %B %Y"), starts_at_time: @event.starts_at.strftime("%H:%M"), ends_at_time: @event.ends_at.strftime("%H:%M"))
      elsif DateTime.now >= @event.starts_at && DateTime.now <= @event.ends_at
        set_flash_message!(:notice, :during_event_message, event_name: @event.name, starts_at_date: @event.starts_at.strftime("%a %d %B %Y"), ends_at_date: @event.ends_at.strftime("%a %d %B %Y"), starts_at_time: @event.starts_at.strftime("%H:%M"), ends_at_time: @event.ends_at.strftime("%H:%M"))
      end
      @event
    end
  
    def after_sign_out_path_for(resource)
      @event
    end
    
    def require_no_authentication
      sign_out current_user if request.path.include?('sign_in') && !(params[:controller] == 'events/sessions' && params[:action] == 'create')
      super
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
