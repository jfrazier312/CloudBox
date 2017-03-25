require 'rails_helper.rb'
require 'helpers/spec_test_helpers.rb'

feature 'Create a new account' do

  it 'successfully creates a new account and logs in' do
    visit new_user_path
    username = Faker::Name.name
    fill_in 'Username', with: username
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: "password"
    fill_in 'Confirm Password', with: "password"
    click_button 'Submit'
    expect(page).to have_content 'User successfully created'
    expect(page).to have_current_path login_path
    fill_in 'Username', with: username
    fill_in 'Password', with: "password"
    click_button 'Log in'
    expect(page).to have_current_path user_path(User.find_by(username: username).id)
    expect(page).to have_content('Username')
    expect(page).to have_content(username)
    expect(page).to have_content('Email')
    expect(page).to have_content(User.find_by(username: username).email)
  end


  context 'Logging out' do
    scenario 'user logs out successfully' do
      login(:user_admin)
      visit posts_path
      find_link('drop_down_account').click
      find_link('Log out').click
      expect(page). to have_current_path root_path
      expect(page).to have_content 'Sign up | Log in'
    end
  end

end