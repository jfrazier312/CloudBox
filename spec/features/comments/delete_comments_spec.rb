require 'rails_helper'
require 'helpers/spec_test_helpers.rb'
require 'pry';

feature 'Deleting comments' do
  background do
    user = create :user_regular
    user_two = create(:user_regular)

    @post = create :post

    comment = create(:comment, user_id: user_two.id,
                     id: 1,
                     post_id: @post.id,
                      content: "first comment")
    comment_two = create(:comment, user_id: user.id,
                         id: 2,
                         post_id: @post.id,
                         content: 'second comment')

    login_as(user_two)
  end

  after :each do
    DatabaseCleaner.clean
  end

  scenario 'user can delete their own comments' do
    visit post_path(@post)

    expect(page).to have_content('first comment')
    click_link 'delete-1'
    expect(page).to_not have_content('first comment')
  end

  scenario 'user cannot delete a comment not belonging to them via the ui' do
    visit post_path(@post)

    expect(page).to have_content('second comment')
    expect(page).to_not have_css('#delete-2')
  end
end