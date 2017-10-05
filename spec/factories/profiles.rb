require 'ffaker'

FactoryGirl.define do
  factory :profile do
    user
    name { FFaker::Name.name  }
    nickname "MyString"
    birthday "2017-07-21"
    specialities "MyText"
    in_network "MyText"
    contact "MyText"
    image 'images/norman.png'
    status :inactive

    factory :invalid_profile do
      name nil
    end

    factory :invalid_status do
      status nil
    end

    factory :active_status do
      status :active
    end

    factory :deactivated_status do
      status :deactivated
    end

  end
end
