require 'rails_helper.rb'

require 'helpers/spec_test_helpers.rb'

RSpec.describe "Creating Posts Feature Test", :type => :feature do

  before :each do
    login(:user_admin)
  end

  after :each do |example|
    unless example.metadata[:skip_after]
      User.destroy(@user.id)
    end
  end

  def visit_new_post
    visit '/'
    find_link('New Post').click
  end

  it 'can create a post' do
    visit_new_post
    attach_file('Image', "app/assets/images/img_00.jpg")
    fill_in 'Caption', with: 'lmao fuck'
    click_button 'Submit'
    expect(page).to have_content('lmao fuck')
    expect(page).to have_css("img[src*='img_00.jpg']")
  end

  it 'needs an image to create a post' do
    visit_new_post
    fill_in 'Caption', with: 'caption'
    click_button 'Submit'
    expect(page).to have_content("Post cannot be saved!")
  end

  it 'doesnt need a caption to create a post' do
    visit_new_post
    attach_file('Image', "app/assets/images/img_00.jpg")
    click_button 'Submit'
    expect(page).to have_no_content('anycaption')
    expect(page).to have_css("img[src*='img_00.jpg']")
  end


end