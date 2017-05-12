require 'rails_helper'

describe Transaction do
  let(:transaction) { FactoryGirl.build :transaction }
  subject { transaction }

  it { should respond_to(:amount) }
  it { should respond_to(:currency) }
  it { should respond_to(:status) }
  it { should respond_to(:tran_type) }
  it { should respond_to(:currency) }
  it { should respond_to(:owner_id) }
  it { should respond_to(:currency) }

  context "with invalid parameters" do
    before(:each) do
      @invalid_transaction = FactoryGirl.build :invalid_transaction
    end

    it "should not be valid" do
      expect(@invalid_transaction).to_not be_valid
    end
  end
end
