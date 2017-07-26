FactoryGirl.define do
  factory :profile do
    user
    name "MyString"
    nickname "MyString"
    birthday "2017-07-21"
    specialities "MyText"
    in_network "MyText"
    contact "MyText"
    image 'images/norman.png'

    factory :invalid_profile do
      name nil
    end

  end
end
