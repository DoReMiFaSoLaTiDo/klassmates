FactoryGirl.define do
  factory :transaction do
    tran_type 0
    amount "9.99"
    currency 1
    status 0
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
  end
end
