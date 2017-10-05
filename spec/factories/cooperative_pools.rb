FactoryGirl.define do
  factory :cooperative_pool do
    naira_balance "9.99"
    us_dollar_balance "9.99"
    gb_pound_balance "MyString"
    transaction nil
  end
end
