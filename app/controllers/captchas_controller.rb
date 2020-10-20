class CaptchasController < ApplicationController
  def index
  end

  def create
    @user = User.new(params[:user].permit(:name))
    if verify_recaptcha(model: @user) && @user.save
      redirect_to @user
    else
      render 'new'
    end
    if verify_recaptcha
      render plain: 'YES'
    else
      render plain: 'NO'
    end
  end
end