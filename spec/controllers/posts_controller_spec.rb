require 'rails_helper'
require 'helpers/posts_helper'
require 'helpers/spec_test_helpers'
require 'pry'

feature 'Posts Controller spec tests' do

  feature 'user edits non owned post' do

    before :each do
      @user = create :user_standard
      @post = create :post, user_id: @user.id
    end

    scenario 'user does not own post' do
      login(:user_standard)
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


  feature 'pagination of posts' do
    skip "this takes too fuckin long. only test occasionally" do
      before :each do
        create_multiple_posts(11)
      end
      scenario 'checks all pages of posts', js: true do
        login(:user_standard)
        comment_string="my new comment"
        visit posts_path
        expect(page).to have_content('Previous')
        expect(page).to have_content('Next')
        expect(page).to have_content('1')
        expect(page).to have_content('2')
        click_link 'Next'
        expect(page).to have_css('.comment_content')
        find('.comment_content').set(comment_string + "\n")
        expect(page).to have_content(@user.username)
        expect(page).to have_content(comment_string)
      end
    end
  end

  feature 'posts are ordered by descending created_at time' do
    # before :each do
    #   create_multiple_posts(3)
    #   login(:user_regular)
    # end

    scenario 'user creates new post and its put at top' do
      skip "this doesn't test anything : how to get value from div ID? " do
        visit posts_path
        first_post = find('.time-ago', match: :first)
        last_post = page.all('.time-ago').last
        create :post
        binding.pry
        new_first = find('.time-ago', match: :first)
        new_last = page.all('.time-ago').last

        expect(last_post).to eq new_last
        puts first_post
        puts new_first
        expect(first_post).to eq new_first
      end
    end
  end
end
