class Admin::UsersController < ApplicationController
  before_action :set_authentication_method
  before_filter :set_user, only: [:edit, :show, :update]
  before_filter :set_admin, :set_profile

  def index
    @users = User.inactive if params[:status] && params[:status] == "inactive"
    @users = User.inactive if params[:status] && params[:status] == "inactive"
    return @users if @users
    @users = User.includes(:profile).all
  end

  def edit
  end

  def show
  end

  def update

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to dashboard_path, notice: "User Edited Successfully!" }
        format.json { render json: @user }
      else
        format.html { render 'edit' }
        format.json { render json: @user.errors }
      end
    end
  end

  private
    def user_params
      # raise params.inspect
      params.require(:user).permit(:phone, :email, :role_id, profile_attributes: [:name, :status])
    end


    def set_user
      @user = User.find(params[:id])
    end

    def set_admin
      @me = User.find(current_user.id)
    end

    def set_profile
      @profile = Profile.find_by(user_id: @me.id)
    end

end
