class Api::ProfilesController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]

  before_action :set_profile, only: [:show, :edit, :update]

  def index
    @profiles = Profile.all
    render json: @profiles
  end

  def show
  end

  def edit
    @attributes = Profile.attribute_names - %w(id user_id created_at updated_at)
  end

  private

    def profile_params
      params.require(:profile).permit(:image, :name, :nickname, :specialities, :in_network, :birthday, :contact, )
    end

    def set_profile
      @profile = Profile.find_by user_id: current_user.id
    end
end
