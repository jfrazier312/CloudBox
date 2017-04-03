require 'rails_helper.rb'
require 'helpers/spec_test_helpers.rb'
require 'pry';

require 'rails_helper.rb'
require 'helpers/spec_test_helpers.rb'
require 'pry'

feature 'Users Controller Basic Spec Tests' do

  feature 'User can sign in' do
    scenario 'admin signs in' do
      login(:user_admin)
    end
    scenario 'regular user signs in' do
      login(:user_standard)
    end
  end
  feature 'User can sign out' do
    scenario 'admin logs out' do
      login(:user_admin)
      visit root_path
      click_link('Account')
      click_link('Log out')
      expect(page).to have_content('Please sign up or log in!')

    end
    scenario 'user logs out' do
      login(:user_standard)
      visit root_path
      click_link('Account')
      click_link('Log out')
      expect(page).to have_content('Please sign up or log in!')
    end
  end

  feature 'User editing other user' do
    scenario 'user cannot edit other user' do
      other_user = create :user_standard
      login(:user_standard)
      visit user_path(other_user.id)
      expect(page).to have_content('Username')
      expect(page).to have_no_content('Email')
      expect(page).to have_no_content('Privilege')
      expect(page).to have_no_content('Edit')
      visit edit_user_path(other_user.id)
      expect(page).to have_current_path users_path
    end

    scenario 'admin cannot edit other user either' do
      other_user = create :user_standard
      login(:user_admin)
      visit user_path(other_user.id)
      expect(page).to have_content(other_user.username)
      expect(page).to have_content(other_user.email)
      expect(page).to have_content(other_user.privilege)
      expect(page).to have_no_content('Edit')
      visit edit_user_path(other_user.id)
      expect(page).to have_content('You do not have permission to perform this operation')
    end
  end

  feature 'User index page UI test' do
    scenario 'check other user as admin' do
      login(:user_admin)
      reg_user = create :user
      visit user_path(reg_user)
      expect(page).to have_content('Username')
    end
  end

end
