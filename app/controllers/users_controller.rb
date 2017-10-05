class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  before_action :authenticate_with_token!, only: [:update, :destroy]
  before_filter :set_user, only: [:show, :update, :destroy ]

  respond_to :html, :json

  def index
    @users = User.all
    respond_with(@users)
  end

  def show
    respond_with(@user)
  end

  def create
    @user = User.new(approved_params)

    flash[:notice] = "User created successfully" if @user.save
    respond_with(@user)

  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.update(approved_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: @user, status: 201 }
      else
        format.html
        format.json { render json: { errors: @user.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  def after_sign_in_path_for(user)
    dashboard_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def approved_params
      params.require(:user).permit(:id, :phone, :email, :password, :password_confirmation, :role_id, profile_attributes: [:name, :status])
    end

    def render_404
      render json: { error: "Record Not Found", status: 404 }
    end


end
