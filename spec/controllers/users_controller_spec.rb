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
      login(:user_regular)
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
      login(:user_regular)
      visit root_path
      click_link('Account')
      click_link('Log out')
      expect(page).to have_content('Please sign up or log in!')
    end
  end

  feature 'User editing other user' do
    scenario 'user cannot edit other user' do
      other_user = create :user_regular
      login(:user_regular)
      visit user_path(other_user.id)
      expect(page).to have_content('Username')
      expect(page).to have_content('Email')
      expect(page).to have_no_content('Edit')
      visit edit_user_path(other_user.id)
      expect(page).to have_current_path users_path

    end
  end

end
