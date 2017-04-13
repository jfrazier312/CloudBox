class AddPrivacyToAssets < ActiveRecord::Migration[5.0]
  def change
    add_column :assets, :privacy, :integer
  end
end
