FactoryGirl.define do

  environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")

  def seed_image(file_name)
    File.open(File.join(Rails.root, "/app/assets/images/#{file_name}.jpg"))
  end


  factory :post do
    arr = %w[img_00 img_01 img_02 img_03 img_04 img_05 img_06 img_07]
    user = User.create!(username: FFaker::Name.name, email: FFaker::Internet.email.downcase, password: 'password', password_confirmation: 'password')
    caption Faker::Lorem.paragraph(2, true, 1)
    image_file_name seed_image(arr.sample)
  end

end