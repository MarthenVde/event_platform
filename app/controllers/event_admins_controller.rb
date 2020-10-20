class EventAdminsController < ApplicationController
   
  #For logged out user
  def new_event_and_admin
    @user = User.new
    @event = Event.new
  end

  def create_event_and_admin
    @user = User.new(user_params)
    @event = Event.new(name: event_params[:event_name], description: event_params[:event_description])
  
    @user.event_admins << EventAdmin.new(event: @event)
    respond_to do |format|
      if @user.save
        format.html { redirect_to event_path(@event), notice: 'User and Event was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new_register_to_host_path}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end 

 #for logged in user
  def new_event_for_user
    @company = Company.new
    @event = Event.find(params[:id])
  end

  def create_event_for_user
    @user = current_user
    #@event = Event.find(params[:id]) this needs to be an initialised Event

  

    respond_to do |format|
      if @user.save
        format.html { redirect_to event_path(@event), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new_event_for_user_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name, :last_name, :country, :phone)
  end

  def event_params
    params.require(:user).permit(:event_name, :event_description)
  end
  
  def event_with_user_params
    params.require(:user).permit(:event_name, :event_description)
  end
end