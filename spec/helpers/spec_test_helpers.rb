module SpecTestHelper
  def login(name)
    user = FactoryGirl.create(name)
    # user = User.create!(username: 'usernameasdf', email: 'asdfea2@asdf', password: 'password', password_confirmation: 'password', privilege: 'admin')
    login_as(user)
  end

  def login_as(user)
    visit login_path
    puts user.username
    puts user.password
    fill_in 'Username', :with => user.username
    fill_in 'Password', :with => user.password
    click_button 'Log in'
    expect(page).to have_content(user.username)
  end
end

RSpec.configure do |config|
  config.include SpecTestHelper, :type => :feature
end