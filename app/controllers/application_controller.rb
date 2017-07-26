class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :ensure_json_request

  protect_from_forgery with: :null_session,
  if: Proc.new { |c| c.request.format =~ %r{application/json} }

  include Authenticable

  def after_sign_in_path_for(resource)
    profile_path(resource)
  end

  def after_sign_up_path_for(resource)
    profile_path(resource)
  end

  private

    def ensure_json_request
      return if request.format == :json
      render nothing: true, status: 406
    end
end
