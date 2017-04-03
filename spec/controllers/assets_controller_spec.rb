require 'rails_helper'
require 'helpers/spec_test_helpers'
require 'pry'

feature 'Assets Controller Spec Tests: ' do

  before :each do
    login(:user_standard)
  end

  scenario 'Test Asset UI links' do
    skip "this is not a feature anymore, using table and tab pane" do
      visit user_path(@user)
      expect(page).to have_selector(:link_or_button, 'My Files')
      click_link('My Files')
      expect(page).to have_current_path user_assets_path(@user)
      verify_assets_page_UI_elements
    end
  end

  scenario 'Checks an asset is on index page' do
    # extend ActionDispatch::TestProcess
    # @file = fixture_file_upload('/files/cloud.png', 'image/png')
    # @file = fixture_file_upload('files/cloud.png', 'image/png')
    # Asset.create! :uploaded_file => File.new(Rails.root + 'spec/fixtures/files/cloud.png'), user_id: @user.id, description: 'desc', custom_name: 'custom_name'
    # post :uploaded_file, :upload => @file
    # Image.new :uploaded_file => File.new(Rails.root + 'spec/fixtures/files/rails.png')

    asset = create :asset, user_id: @user.id
    visit user_assets_path(@user)
    verify_assets_page_UI_elements
    expect(page).to have_content(asset.description)
    expect(page).to have_content(asset.custom_name)
    expect(page).to have_content(asset.filename)
    expect(page).to have_content("Edit")
    expect(page).to have_content("Delete")
  end
end

private

def verify_assets_page_UI_elements
  expect(page).to have_content("Files")
  expect(page).to have_content("Name")
  expect(page).to have_content("Filename")
  expect(page).to have_content("Description")
  expect(page).to have_selector(:link, "Upload File")
end