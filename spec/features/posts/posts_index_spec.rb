require 'rails_helper.rb'
require 'helpers/spec_test_helpers.rb'

feature 'Index displays list of posts' do

  before :each do
    login(:user_admin)
  end

  scenario 'the index displays all posts and info' do
    post_one = FactoryGirl.create(:post, caption: "first post")
    post_two = FactoryGirl.create(:post, caption: "second post")
    visit posts_path
    expect(page).to have_content 'first post'
    expect(page).to have_content 'second post'
  end


end