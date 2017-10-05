class ProfilesController < ApplicationController
  before_action :set_authentication_method
  before_filter :set_profile, only: [:edit, :delete, :update]

  def edit
  end

  def update

    respond_to do |format|
      if @profile.update_attributes(profile_params)
        format.html { redirect_to dashboard_path, notice: "Profile Edited Successfully!" }
        format.json { render json: @profile }
      else
        format.html { render 'edit' }
        format.json { render json: @profile.errors }
      end
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
