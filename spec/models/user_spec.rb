require 'rails_helper'

describe User do
  before {@user = FactoryGirl.create :user }

  subject{ @user }

  it { should be_valid }
  it { should respond_to :phone }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :auth_token }

  it "is not valid without a phone number" do
    expect( FactoryGirl.build(:user, phone: nil) ).to_not be_valid
  end

  it "is not valid without an email" do
    expect( FactoryGirl.build(:user, email: nil) ).to_not be_valid
  end

  describe "#contribution association" do
    before { FactoryGirl.create :contribution, user: @user }

    it "destroys the associated contribution account on self destruct" do
      contribution = @user.contribution
      @user.destroy
      expect{ Contribution.find(contribution.id) }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      Devise.stub(:friendly_token).and_return("myuniquetoken567")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "myuniquetoken567"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "myuniquetoken567")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

end
