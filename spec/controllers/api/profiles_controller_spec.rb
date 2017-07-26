require 'rails_helper'
require 'ffaker'

describe Api::ProfilesController do
  before(:each) { request.headers['Accept'] = "application #{Mime::JSON}"}
  before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }

  describe "GET #show" do
    before(:each) do
      @profile = FactoryGirl.create(:profile)
      get :show, id: @profile.id
    end

    it "should return success code 200" do
      expect(response.status).to eql 200
    end

    it "returns profile details" do
      result = parsed_response
      expect(result[:name]).to eql @profile.name
    end
  end

end
