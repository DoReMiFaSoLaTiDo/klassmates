module Authenticable

  # Devise methods overwrites
  def current_user
    super if request.format == 'text/html'
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  # def authenticate_user!
  #   super
  # end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

  # def authorized_user(rol)
  #   status: :unauthorized unless current_user.role_id == role[rol]
  # end
end
