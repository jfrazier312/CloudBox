class AddSharedWithFriendsColumnToAssets < ActiveRecord::Migration[5.0]
  def change
    add_column :assets, :shared_with_friends, :boolean
  end
end
