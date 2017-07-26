class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
    @user.build_profile
  end

  private

  def sign_up_params
    params.require(:user).permit(:phone, :role_id, :email, :password, :password_confirmation, profile_attributes: [:name])
  end

  def account_update_params
    params.require(:user).permit(:phone, :role_id, :email, :password, :password_confirmation, profile_attributes: [:name])
  end
end
