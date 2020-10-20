class ZoomUsersController < ApplicationController
  before_action :set_zoom_user, only: [:show, :edit, :update, :destroy]

  # GET /zoom_users
  # GET /zoom_users.json
  def index
    @zoom_users = ZoomUser.all
  end

  # GET /zoom_users/1
  # GET /zoom_users/1.json
  def show
  end

  # GET /zoom_users/new
  def new
    @zoom_user = ZoomUser.new
  end

  # GET /zoom_users/1/edit
  def edit
  end

  # POST /zoom_users
  # POST /zoom_users.json
  def create
    @zoom_user = ZoomUser.new(zoom_user_params)
    
    respond_to do |format|
      if @zoom_user.save
        ZoomUserCreateJob.perform_later(@zoom_user.id)
        format.html { redirect_to @zoom_user, notice: 'Zoom user was successfully created.' }
        format.json { render :show, status: :created, location: @zoom_user }
      else
        format.html { render :new }
        format.json { render json: @zoom_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zoom_users/1
  # PATCH/PUT /zoom_users/1.json
  def update
    respond_to do |format|
      if @zoom_user.update(zoom_user_params)
        format.html { redirect_to @zoom_user, notice: 'Zoom user was successfully updated.' }
        format.json { render :show, status: :ok, location: @zoom_user }
      else
        format.html { render :edit }
        format.json { render json: @zoom_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zoom_users/1
  # DELETE /zoom_users/1.json
  def destroy
    zoom_user_id = @zoom_user.zoom_user_id
    @zoom_user.destroy
    ZoomUserDestroyJob.perform_later(zoom_user_id)
    respond_to do |format|
      format.html { redirect_to zoom_users_url, notice: 'Zoom user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zoom_user
      @zoom_user = ZoomUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def zoom_user_params
      params.require(:zoom_user).permit(:email, :first_name, :last_name, :user_type, :zoom_user_id)
    end
end
