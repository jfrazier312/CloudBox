FactoryGirl.define do

  factory :post do
    caption Faker::Lorem.paragraph(2, true, 1)
    image { File.open(File.join(Rails.root, "/app/assets/images/img_00.jpg")) }

    user do
      FactoryGirl.create(:user, username: Faker::Name.name)
    end

  end

end