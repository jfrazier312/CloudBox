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
    expect(page).to have_content(username)
    expect(page).to have_current_path user_path(User.find_by(username: username).id)
    expect(page).to have_content(username)
    expect(page).to have_content('Email')
    expect(page).to have_content('regular')
  end


  context 'Logging out' do
    skip "Can't figure out drop downs yet" do
      scenario 'user logs out successfully' do
        login(:user_admin)
        visit posts_path
        find('.dropdown-menu', visible: :all)
        find('.dropdown-menu.li', text: 'Log out', visible: :all).click
        expect(page). to have_current_path root_path
        expect(page).to have_content 'Sign up | Log in'
        # find_link('Log out', visible: :all).select_option

      end
    end
  end

end