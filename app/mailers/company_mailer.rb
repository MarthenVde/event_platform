class CompanyMailer < ApplicationMailer
  def contact_email
    @company = Company.find(params[:company_id])
    @contact_params = params[:contact_params]
    @event = @company.event
    mail(to: @company.email, subject: "Contact Request for #{@company.name}", from: "#{@contact_params[:first_name]} #{@contact_params[:last_name]} <#{@company.event.mail_setting.email}>", reply_to: @contact_params[:email], delivery_method_options: delivery_options)
  end

  def assist_email
    @company = Company.find(params[:company_id])
    @event = @company.event
    mail(to: @company.email, subject: "Assist Request for #{@company.name}", from: "#{@company.name} <#{@company.event.mail_setting.email}>", reply_to: "#{@company.email}", delivery_method_options: delivery_options)
  end

  def new_company_email
    @company = Company.find(params[:company_id])
    @exhibitor_list = params[:exhibitor_list]
    @event = Event.find(params[:event_id])

    mail(to: @company.email, subject: "New Stall Setup: #{@company.name}", from: @event.mail_setting.email, reply_to: @company.email, delivery_method_options: delivery_options)
  end

  def new_exhibitor_welcome
    @company = Company.find(params[:company_id])
    @event = Event.find(params[:event_id])
    @email = params[:email]
    @user = User.find_by(email: @email)
    @password = params[:password]
    mail(to: @email, subject: "You were added as an exhibitor on: #{@company.name}", from: @event.mail_setting.email, reply_to: @company.email, delivery_method_options: delivery_options)
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