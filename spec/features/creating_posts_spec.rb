require 'rails_helper.rb'

require 'helpers/spec_test_helpers.rb'

RSpec.describe "Creating Posts Feature Test", :type => :feature do

  before :each do
    login(:user)
  end

  scenario 'can create a post' do
    visit '/'
    find_link('New Post').click
    attach_file('Image', "app/assets/images/img_00.jpg")
    fill_in 'Caption', with: 'lmao fuck'
    click_button 'Submit'
    expect(page).to have_content('lmao fuck')
    expect(page).to have_css("img[src*='img_00.jpg']")
  end
end