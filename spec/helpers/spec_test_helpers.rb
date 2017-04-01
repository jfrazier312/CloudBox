require 'rails_helper'
require 'posts_helper'

module SpecTestHelper
  def login(name)
    @user = FactoryGirl.create(name)
    login_as(@user)
  end

  def login_as(user)
    visit login_path
    fill_in 'Username', :with => user.username
    fill_in 'Password', :with => user.password
    click_button 'Log in'
    expect(page).to have_content(user.username)
  end


end

RSpec.configure do |config|
  config.include SpecTestHelper, :type => :feature
end