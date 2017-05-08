require 'ffaker'

FactoryGirl.define do
  factory :user do
    role 
    phone { FFaker::PhoneNumber.short_phone_number }
    email { FFaker::Internet.email }
    password "12345678"
    password_confirmation "12345678"

    factory :invalid_user do
      email nil
    end
  end
end
