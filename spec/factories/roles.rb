FactoryGirl.define do
  factory :role do
    name "MoneyBag"
    description "MoneyBag Team Member"

    factory :invalid_role do
      name nil
    end
  end
end
