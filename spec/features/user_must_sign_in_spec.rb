require 'rails_helper.rb'
require 'helpers/spec_test_helpers.rb'

feature 'user cannot access features without logging in' do

  context 'post controller actions' do
    scenario 'user visits posts index' do
      visit posts_path
      expect(page).to have_content 'Login is required to access page'
    end

    scenario 'user attempts to create post' do
      visit new_post_path
      expect(page).to have_content 'Login is required to access page'
    end

    scenario 'user attempts to edit post' do
      post = FactoryGirl.create(:post)
      visit post_path(post.id)
      expect(page).to have_content 'Login is required to access page'
    end
  end


  context 'user controller actions' do
    scenario 'user visits users index' do
      visit users_path
      expect(page).to have_content 'Login is required to access page'
    end

    scenario 'user visits other users profile' do
      user = FactoryGirl.create(:user)
      visit user_path(user.id)
      expect(page).to have_content 'Login is required to access page'
    end
  end

end