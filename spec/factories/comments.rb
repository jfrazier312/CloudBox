FactoryGirl.define do

  factory :comment do
    content Faker::Lorem.paragraph(1, true, 1)
    user do
      FactoryGirl.create(:user, username: Faker::Name.name)
    end
    post do
      FactoryGirl.create(:post)
    end
  end
end