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

  context "specialized test on amount" do
    before(:each) do
      @string_transaction_amount = FactoryGirl.build :transaction, amount: '2b.aa'
      @negative_transaction_amount = FactoryGirl.build :transaction, amount: -11
    end

    it "should validate numericality of amount greater than or equal to 0" do
      expect(@string_transaction_amount).to_not be_valid
      expect(@negative_transaction_amount).to_not be_valid
    end
  end

  context "specialized test on transaction verification" do
    before(:each) do
      user = FactoryGirl.create :user
      verifier = FactoryGirl.create :verifier
      @invalid_transaction = FactoryGirl.build :transaction, owner_id: user.id, verifier_id: user.id
      @valid_transaction = FactoryGirl.build :transaction, status: :verified,
                owner_id: user.id, verifier_id: verifier.id
    end


    it "should not be valid when owner and verifier are the same" do
      @invalid_transaction.valid?
      expect( @invalid_transaction.errors[:verifier_id] ).to include "Owner cannot verify own transaction"
    end

    it "should be valid when owner and verifier are different" do
      expect(@valid_transaction).to be_valid
    end
  end

  context "with invalid parameters" do
    before(:each) do
      @invalid_transaction = FactoryGirl.build :invalid_transaction
      @unfunded_transaction = FactoryGirl.build :unfunded_transaction
    end

    it "should not be valid" do
      expect(@invalid_transaction).to_not be_valid
      expect(@unfunded_transaction).to_not be_valid
    end
  end
end
