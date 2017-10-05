class DashboardController < ApplicationController
  before_action :set_authentication_method
  before_filter :set_user, only: [:show]

  # raise @authenticate_method.inspect

  def show
    @profile = Profile.find_by(user_id: @user.id)
    @trans = Transaction.most_recent
    flash[:success ] = "Welcome to Klassmates portal"
    # raise @user_profile.inspect
  end

  protected

    def set_user
      @user = User.find(current_user.id)
    end

end
