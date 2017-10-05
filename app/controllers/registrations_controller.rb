class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(sign_up_params)

    flash[:notice] = "Profile created successfully" if @user.save
    #
    #   respond_to do |format|
    #     format.html { redirect_to: :dashboard }
    #     format.json { respond_with(@user) }
    #   end
    # else
    respond_with(@user)
    # end
    # super # this calls Devise::RegistrationsController#create as usual
    # after creating a new user, create a profile that has
    # the profile.user_id field set to the user_id of the user jsut created
  end

  private

  def sign_up_params
    # raise params.inspect
    params.require(:user).permit(:phone, :role_id, :email, :password, :password_confirmation, profile_attributes: [:name, :status])
  end

  def account_update_params
    params.require(:user).permit(:phone, :role_id, :email, :password, :password_confirmation, profile_attributes: [:name, :status])
  end

  def after_sign_up_path_for(user)
    dashboard_path
  end

end
