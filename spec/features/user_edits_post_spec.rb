require 'rails_helper.rb'
require 'helpers/spec_test_helpers.rb'

feature 'User editing posts' do

  context 'Regular user is editing posts' do
    before :each do
      login(:user_regular)
    end

    scenario 'User edits own post successfully' do
      post_one = FactoryGirl.create(:post, caption: "I need to edit this!", user: @user)
      visit post_path(post_one.id)
      expect(page).to have_content 'I need to edit this!'
      find_link('Edit').click
      expect(page).to have_current_path edit_post_path(post_one.id)
      fill_in 'Caption', with: 'Edited Caption'
      click_button('Submit')
      expect(page).to have_content 'Post updated'
      expect(page).to have_content 'Edited Caption'
    end

    scenario 'User cannot edit non owned post' do
      post_one = FactoryGirl.create(:post, caption: "caption", user: FactoryGirl.create(:user, username: Faker::Name.name))
      visit post_path(post_one.id)
      expect(page).to have_current_path post_path(post_one.id)
      expect(page).not_to have_selector(:link_or_button, 'Edit')
      visit edit_post_path(post_one.id)
      expect(page).to have_content 'Cannot alter this post'
    end
  end

  context 'Admin user is editing posts' do
    before :each do
      login(:user_admin)
    end

    scenario 'admin edits own post successfully' do
      post_one = FactoryGirl.create(:post, caption: "I need to edit this!", user: @user)
      visit post_path(post_one.id)
      expect(page).to have_content 'I need to edit this!'
      find_link('Edit').click
      expect(page).to have_current_path edit_post_path(post_one.id)
      fill_in 'Caption', with: 'Edited Caption'
      click_button('Submit')
      expect(page).to have_content 'Post updated'
      expect(page).to have_content 'Edited Caption'
    end

    scenario 'Admin can edit non owned post' do
      post_one = FactoryGirl.create(:post, caption: "caption", user: FactoryGirl.create(:user, username: Faker::Name.name))
      visit post_path(post_one.id)
      expect(page).to have_current_path post_path(post_one.id)
      find_link('Edit').click
      fill_in 'Caption', with: 'Edited Caption'
      click_button('Submit')
      expect(page).to have_content 'Post updated'
      expect(page).to have_content 'Edited Caption'
    end
  end


end