FactoryGirl.define do

  factory :user, class: User do
    username { FFaker::Name.name }
    email { FFaker::Internet.email.downcase }
    password 'password'
    password_confirmation 'password'
    privilege 'admin'

    factory :user_admin do
      privilege 'admin'
    end

    factory :user_regular do
      privilege 'regular'
    end
  end

end