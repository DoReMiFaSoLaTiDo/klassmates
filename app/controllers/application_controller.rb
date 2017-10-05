class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  # before_action :set_authentication_method

  include Authenticable

  def after_sign_in_path_for(resource)
      dashboard_path(resource)
  end

  def after_sign_up_path_for(resource)
    dashboard_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def set_authentication_method
    # authenticate_method = { 'text/html'}
    return :authenticate_user! if request.format == 'text/html'
    :authenticate_with_token!
  end


end
