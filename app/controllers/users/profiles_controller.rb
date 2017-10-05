class Users::ProfilesController < ApplicationController
  before_action :set_authentication_method
  before_filter :set_profile, only: [:edit, :delete, :update]

  def edit
  end

  def update
    @profile.update_attributes(profile_params)

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: "Profile Edited Successfully!" }
      format.json { render json: @profile }
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:user_id, :name, :nickname, :birthday, :specialities, :in_network, :contact, :status, :image )
    end


    def set_profile
      @profile = Profile.find(params[:id])
    end

end
