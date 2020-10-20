class ApplyToAttendController < ApplicationController
  def new_user
    @user = User.new
    @event = Event.find(params[:id])
  end

  def create_user
    @user = User.new(user_params)
    @event = Event.find(params[:id])
    
    @user.event_attendees << EventAttendee.new(event: @event)
    respond_to do |format|
      if @user.save
        if DateTime.now < @event.starts_at
          EventMailer.with(user_id: @user.id, event_id: @event.id).before_event_email.deliver_later
        elsif DateTime.now > @event.ends_at
          EventMailer.with(user_id: @user.id, event_id: @event.id).after_event_email.deliver_later
        elsif DateTime.now >= @event.starts_at && DateTime.now <= @event.ends_at
          EventMailer.with(user_id: @user.id, event_id: @event.id).during_event_email.deliver_later
        end
          format.html { redirect_to @event, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new_user }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:language, :email, :password, :name, :last_name, :country, :phone, :user_description_selects)
  end

end
