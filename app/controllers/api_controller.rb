class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :ensure_json_request

  private

    def ensure_json_request
      return if request.format == :json
      render nothing: true, status: 406
    end
end
