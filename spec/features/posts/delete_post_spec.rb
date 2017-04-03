require 'rails_helper.rb'
require 'helpers/spec_test_helpers.rb'

# TODO Figure out how to simulate confirmation dialog
feature 'User deleting posts' do

  context 'Regular user is deleting posts' do
    before :each do
      login(:user_standard)
    end

    scenario 'User deletes own post successfully' do
      post_one = FactoryGirl.create(:post, caption: "I need to delete this!", user: @user)
      visit post_path(post_one.id)
      expect(page).to have_content 'Delete'
    end

    scenario 'User cannot delete non owned post' do
      post_one = FactoryGirl.create(:post, caption: "caption", user: FactoryGirl.create(:user, username: Faker::Name.name))
      visit post_path(post_one.id)
      expect(page).to have_current_path post_path(post_one.id)
      expect(page).not_to have_selector(:link_or_button, 'Delete')
    end
  end

  context 'Admin user is deleting posts' do
    before :each do
      login(:user_admin)
    end

    scenario 'admin delete own post successfully' do
      post_one = FactoryGirl.create(:post, caption: "I need to delete this!", user: @user)
      visit post_path(post_one.id)
      expect(page).to have_content 'I need to delete this!'
      find_link('Delete').click
    end

    scenario 'Admin can delete non owned post' do
      post_one = FactoryGirl.create(:post, caption: "caption", user: FactoryGirl.create(:user, username: Faker::Name.name))
      visit post_path(post_one.id)
      expect(page).to have_current_path post_path(post_one.id)
      find_link('Delete').click
    end
  end


end