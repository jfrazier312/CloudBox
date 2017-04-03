FactoryGirl.define do

  factory :asset do
    user do
      create :user
    end

    uploaded_file File.new(Rails.root + 'spec/fixtures/files/cloud.png')
    description { Faker::Lorem.paragraph(1, true, 1) }
    custom_name { Faker::Name.name }

  end

end