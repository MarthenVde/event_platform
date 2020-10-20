class EventMailer < ApplicationMailer
  def contact_email
    @event = params[:event]
    @contact_params = params[:contact_params]

    mail(to: @event.email, subject: "Contact Request for #{@event.name}", from: "#{@contact_params[:first_name]} #{@contact_params[:last_name]} <#{@event.mail_setting.email}>", reply_to: @contact_params[:email], delivery_method_options: delivery_options)
  end

  def before_event_email

    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    mail(to: @user.email, subject: "Welcome  #{@user.name}", from: @event.mail_setting.email, delivery_method_options: delivery_options)
  end

  def during_event_email
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    mail(to: @user.email, subject: "Welcome  #{@user.name}", from: @event.mail_setting.email, delivery_method_options: delivery_options)
  end

  def after_event_email
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    mail(to: @user.email, subject: "Welcome  #{@user.name}", from: @event.mail_setting.email, delivery_method_options: delivery_options)
  end

  def send_reset_instructions
    @event = Event.find(params[:event_id])
    @token = params[:token]
    @user = User.find(params[:user_id])
    mail(to: @user.email, subject: "Reset password instructions for #{@user.name}", from: @event.mail_setting.email, delivery_method_options: delivery_options)
  end

  def delivery_options 
    { 
      address: @event.mail_setting.address,
      port: @event.mail_setting.port,
      authentication: "plain",
      user_name: @event.mail_setting.email,
      password: @event.mail_setting.password,
      enable_starttls_auto: true
    }
  end

  
end