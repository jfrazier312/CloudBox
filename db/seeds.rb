# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.delete_all

environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")

def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/#{file_name}.jpg"))
end

8.times do |n|

 # arr = %w[img_00 img_01 img_02]

  username = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"

  user =  User.create!(username: username,
                       email: email,
                       password: password,
                       password_confirmation: password
  );

  username2 = Faker::Name.name
  email2 = "example2-#{n+1}@example.com"
  password2 = "password"

  user2 = User.create!(username: username2,
                       email: email2,
                       password: password,
                       password_confirmation: password
  );

  Friend.create!(
            user_1_id: user.id,
            user_2_id: user2.id
  )

  Asset.create!(
           user_id: user.id,
           uploaded_file: seed_image("img_0#{n}"),
           filename: 'filename!',
           custom_name: 'custom_name!',
           description: 'my desciprtion',
           privacy: 'private'
  )

  Post.create!(
      #image: seed_image(arr.sample),
      image: seed_image("img_0#{n}"),

      caption: Faker::Lorem.paragraph(2, true, 1),
      user_id: user.id
  );


end

User.create!(username: 'admin', email: 'admin123@email.com', password: 'password', password_confirmation: 'password', privilege: 'admin')
User.create!(username: 'regular', email: 'regular123@email.com', password: 'password', password_confirmation: 'password')

