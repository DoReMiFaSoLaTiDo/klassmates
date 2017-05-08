require 'rails_helper'

describe Role do
  let(:role) { FactoryGirl.build :role }
  subject { role }

  it { should respond_to(:name) }
  it { should respond_to(:description) }

  context "with invalid parameters" do
    before(:each) do
      @invalid_role = FactoryGirl.build :role
      @invalid_role.tap { |ip| ip.name = nil }
    end

    it "should not be valid" do
      expect(@invalid_role).to_not be_valid
    end
  end
end
