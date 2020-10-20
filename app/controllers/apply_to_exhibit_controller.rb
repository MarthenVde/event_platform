class ApplyToExhibitController < ApplicationController

  def index
  end
  
  def new_company_and_user
    @user = User.new
    @event = Event.find(params[:id])
  end

  def create_company_and_user
    @user = User.new(user_params)
    @event = Event.find(params[:id])
    @company = Company.new(event_id: params[:id], name: company_with_user_params[:company_name], description: company_with_user_params[:company_description], email: company_with_user_params[:company_email])
    @user.company_exhibitors << CompanyExhibitor.new(company: @company)

    respond_to do |format|
      if @user.save 
        format.html { redirect_to edit_event_company_path(@event, @company), notice: 'User and Company was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new_company_and_user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end 


  def new_company_for_user
    @company = Company.new
    @event = Event&.find(params[:id])
  end

  def create_company_for_user
    @user = current_user
    @event = Event.find(params[:id])
    @company = Company.new(event_id: params[:id], name: company_for_user_params[:company_name], description: company_for_user_params[:company_description])
    @user.company_exhibitors << CompanyExhibitor.new(company: @company)

    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_event_company_path(@event, @company), notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new_company_for_user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name, :last_name, :country, :phone)
  end

  def company_for_user_params
    params.require(:company).permit(:company_name, :company_description)
  end
  
  def company_with_user_params
    params.require(:user).permit(:company_name, :company_description, :company_email)
  end
end
