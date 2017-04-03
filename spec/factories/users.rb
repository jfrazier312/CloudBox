FactoryGirl.define do

  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"

    factory :user_admin do
      privilege "admin"
    end

    factory :user_standard do
      privilege "standard"
    end
  end

end