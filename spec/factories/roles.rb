FactoryGirl.define do
  factory :role do
    name "Member"
    description "Classmate"

    factory :invalid_role do
      name nil
    end

    factory :moneybag do
      name "MoneyBag"
      description "MoneyBag Team Member"
    end

    factory :admin do
      name "Admin"
      description "Administrator"
    end
  end
end
