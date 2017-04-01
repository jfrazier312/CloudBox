require 'rails_helper'
require 'helpers/spec_test_helpers'
require 'pry'

feature 'Comments Controller spec tests' do

  feature 'user creates comment' do

    before :each do
      @user = create :user_regular
      @post = create :post, user_id: @user.id
    end

    scenario 'user does not own post' do
      login(:user_regular)
      visit post_path(@post.id)
      expect(page).to have_no_content('Edit')
      visit edit_post_path(@post.id)
      expect(page).to have_current_path post_path(@post.id)
      expect(page).to have_content('Cannot alter this post')
    end

    scenario 'admin does not own post but still can edit' do
      login_as(@user)
      visit post_path(@post.id)
      expect(page).to have_content('Edit')
      visit edit_post_path(@post.id)
      expect(page).to have_content('Caption')
      fill_in('Caption', with: 'new caption')
      click_button('Submit')
      expect(page).to have_content('Post updated')
      expect(page).to have_content('new caption')
    end
  end
end