require 'rails_helper'

describe Api::RolesController do
  describe "GET #show" do
    before(:each) do
      @role = FactoryGirl.create :role
      get :show, id: @role.id
    end

    it "returns the details of role" do
      result = parsed_response
      expect(result[:name]).to eql @role.name
    end

    it "returns success code 200 " do
      expect(response.status).to eql 200
    end
  end

  describe "GET #index" do


    it "returns success code 200 " do
      expect(response.status).to eql 200
    end
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        role = FactoryGirl.create :role
        @role_attributes = FactoryGirl.attributes_for :role
        post :create, { role: @role_attributes }
      end

      it "renders the json representation for the role record just created" do
        result = parsed_response
        expect(result[:name]).to eql @role_attributes[:name]
      end

      it "returns success code 201 " do
        expect(response.status).to eql 201
      end
    end

    context "when is not created" do
      before(:each) do
        @invalid_role_attributes = FactoryGirl.attributes_for :invalid_role
        post :create, { role: @invalid_role_attributes }
      end

      it "renders an errors json" do
        result = parsed_response
        expect(result).to have_key(:errors)
      end

      it "renders the json errors on why the role could not be created" do
        result = parsed_response
        expect(result[:errors][:name]).to include "can't be blank"
      end

      it "returns error code 422 " do
        expect(response.status).to eql 422
      end
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @role = FactoryGirl.create :role
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { id: @role.id,
              role: { description: "Team Lead" } }
      end

      it "renders the json representation for the updated role" do
        result = parsed_response
        expect(result[:description]).to eql "Team Lead"
      end

      it "returns success code 200" do
        expect(response.status).to eql 200
      end
    end

    context "with invalid attributes" do
      before(:each) do
        patch :update, { id: @role.id,
              role: { description: nil } }
      end

      it "renders an errors json" do
        result = parsed_response
        expect(result).to have_key(:errors)
      end

      it "renders the json errors on why the role could not be created" do
        result = parsed_response
        # raise result.inspect
        expect(result[:errors][:description]).to include "can't be blank"
      end

      it "returns error code 422" do
        expect(response.status).to eql 422
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @role = FactoryGirl.create :role
      delete :destroy, { id: @role.id }
    end

    it "returns success code 204" do
      expect(response.status).to eql 204
    end
  end
end
