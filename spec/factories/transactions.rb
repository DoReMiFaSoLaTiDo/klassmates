FactoryGirl.define do
  factory :transaction do
    tran_type :credit
    tran_date Date.today
    amount "9.99"
    currency "US Dollar"
    status :unverified
    description "my money transfer"
    verifier_id nil
    owner_id { FactoryGirl.create :user }
    contribution

    factory :verified_transaction do
      verifier_id { FactoryGirl.create :verifier }
      status :verified
    end

    factory :deleted_transaction do
      verifier_id { FactoryGirl.create :verifier }
      status :deleted
    end

    factory :invalid_transaction do
      amount nil
    end

    factory :unfunded_transaction do
      tran_type :debit
      amount 2000.00
    end
  end
end
