require 'rails_helper'
require 'ffaker'
require 'bigdecimal'

describe Api::TransactionsController do
  before(:each) { request.headers['Accept'] = "application #{Mime::JSON}"}
  before(:each) { request.headers['Content-Type'] = Mime::JSON.to_s }
  # before(:each) { @user = FactoryGirl.create :user }

  describe "GET #show" do
    before(:each) do
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      @transaction = FactoryGirl.create :transaction, owner_id: user.id
      get :show, user_id: user.id, id: @transaction.id
    end

    it "should return success code 200" do
      expect(response.status).to eql 200
    end

    it "returns transaction details" do
      result = parsed_response
      expect(BigDecimal(result[:amount])).to eq @transaction.amount
    end
  end

  describe "GET #index" do
    before(:each) do
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      4.times { FactoryGirl.create :transaction, owner_id: user.id }
      get :index, user_id: user.id
    end

    it "returns 4 records from the database" do
      result = parsed_response
      expect(result.size).to eql(4)
    end

    it "returns success code 200 " do
      expect(response.status).to eql 200
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      before(:each) do
        user = FactoryGirl.create :user
        api_authorization_header user.auth_token
        @transaction_attributes = FactoryGirl.attributes_for :transaction, owner_id: user.id
        post :create, { user_id: user.id, transaction: @transaction_attributes }
      end

      it "returns success code 201" do
        expect(response.status).to eql 201
      end

      it "returns details of record created" do
        result = parsed_response
        expect(result[:amount]).to eql @transaction_attributes[:amount]
      end

      it "transaction status is unverified" do
        result = parsed_response
        expect(result[:status]).to eql 'unverified'
      end
    end

    context "when invalid parameters passed" do
      before(:each) do
        user = FactoryGirl.create :user
        api_authorization_header user.auth_token
        @invalid_transaction = FactoryGirl.attributes_for :invalid_transaction
        post :create, { user_id: user.id, transaction: @invalid_transaction }
      end

      it "should return error code 422" do
        expect(response.status).to eql 422
      end

      it "should return error details" do
        result = parsed_response
        expect(result).to have_key :errors
        expect(result[:errors][:amount]).to include "can't be blank"
      end
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @transaction = FactoryGirl.create :transaction, owner_id: @user.id
      # request.headers['Authorization'] =  @user.auth_token
    end

    context "with valid parameters" do
      # before(:each) do
      #   @amount_update = { amount: "550.34" }
      #   @status_update = { status: :verified }
      #
      # end

      it "should return details of updated record" do
        patch :update, { user_id: @user.id, id: @transaction.id, transaction: { amount: "550.34" } }
        result = parsed_response
        expect(result[:amount]).to eql "550.34"
      end

      it "should return success code 201" do
        patch :update, { user_id: @user.id, id: @transaction.id, transaction: { amount: "550.34" } }
        expect(response.status).to eql 201
      end

      it "should add amount to user contribution" do
        previous_balance = Contribution.find(@transaction.contribution_id)[:balance_fcy]
        patch :update, { user_id: @user.id, id: @transaction.id, transaction: { status: :verified } }
        result = parsed_response
        # raise result.inspect
        new_balance = Contribution.find(result[:contribution][:id])[:balance_fcy]
        expect(BigDecimal(new_balance - previous_balance)).to eql @transaction.amount
      end
    end
  #
  #   context "with invalid parameters" do
  #     before(:each) do
  #       put :update, { id: @transaction.id, transaction: { amount: "-101.23" } }
  #     end
  #
  #     it "should return errors" do
  #       result = parsed_response
  #       expect(result).to have_key :errors
  #       expect(result[:errors][:amount]).to include "is invalid"
  #     end
  #
  #     it "should return error code 422" do
  #       expect(response.status).to eql 422
  #     end
  #   end
  end
  #
  # describe "DELETE #destroy" do
  #   before(:each) do
  #     @user = FactoryGirl.create :user
  #     api_authorization_header @user.auth_token
  #     delete :destroy, id: @user.id
  #   end
  #
  #   it "responds with 204" do
  #     expect(response.status).to eql 204
  #   end
  #
  #
  # end

end
