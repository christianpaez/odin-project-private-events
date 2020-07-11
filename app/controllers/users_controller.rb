class UsersController < ApplicationController
  before_action :current_user, except: [:sign_in, :user_session, :new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :user_session]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = current_user
    @upcoming_events = @user.upcoming_events
    @previous_events = @user.previous_events
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        cookies[:user_id] = @user.id
        redirect_to events_path, flash: { info: 'User was successfully created.'} 
      else
        render :new 
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, info: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, info: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /users/sign_in
  def sign_in
  end

  # POST /users/sign_in/:user_id
  def user_session
    cookies[:user_id] = @user.id
    redirect_to events_path, flash: { info: "Welcome back #{@user.name}!" }
  end

  # DELETE /users/:id/logout/
  def destroy_session!
    cookies.delete(:user_id)
    redirect_to sign_in_users_path, flash: {info: "Succesfully Logged Out!"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find_by name: params[:name]
        unless @user
          redirect_to sign_in_users_path, flash: { warning: "User not found, please check your request and try again." }
        end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name)
    end
end
