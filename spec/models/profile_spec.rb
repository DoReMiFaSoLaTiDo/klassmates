require 'rails_helper'

describe Profile do
  before {@profile = FactoryGirl.create :profile }

  subject{ @profile }

  it { should be_valid }
  it { should respond_to :name }
  it { should respond_to :nickname }
  it { should respond_to :birthday }
  it { should respond_to :specialities }
  it { should respond_to :in_network }
  it { should respond_to :contact }
  it { should respond_to :image }

  it "is not valid without a name" do
    expect( FactoryGirl.build(:invalid_profile) ).to_not be_valid
  end


end
