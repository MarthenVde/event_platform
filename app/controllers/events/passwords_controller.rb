# frozen_string_literal: true

class Events::PasswordsController < Devise::PasswordsController
  before_action :set_event
  #GET /resource/password/new
  def new
    super
  end

  #POST /resource/password
  def create
    raw, enc = Devise.token_generator.generate(User, :reset_password_token)
    user = User.find_by(email: resource_params[:email])
    return redirect_to password_new_event_path(@event), flash: { notice: "Invalid user!" } if user.blank?
    user.reset_password_token   = enc
    user.reset_password_sent_at = Time.now.utc
    user.save(validate: false)
    EventMailer.with(user_id: user.id, event_id: @event.id, token: raw).send_reset_instructions.deliver_later
    respond_to do |format|
      format.html { redirect_to event_path(@event), notice: 'Password reset instructions was sent to your email address.' }
    end
  end

  #GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  #PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        resource.after_database_authentication
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      respond_with resource, location: password_edit_event_path(@event)
    end
  end

  protected

  def set_event
    @event = Event.find(params[:id])
  end

  def after_resetting_password_path_for(resource)
    event_path(@event)
  end

  #The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    event_path(@event)
  end
end
