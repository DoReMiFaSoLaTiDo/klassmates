FactoryGirl.define do
  factory :transaction do
    tran_type :credit
    amount "9.99"
    currency "US Dollar"
    status :unverified
    verifier_id nil
    owner_id { FactoryGirl.create :user }
    contribution

    factory :verified_transaction do
      verifier_id { FactoryGirl.create :verifier }
      status 1
    end

    factory :deleted_transaction do
      verifier_id { FactoryGirl.create :verifier }
      status 2
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
