class AddDescriptionToAsset < ActiveRecord::Migration[5.0]
  def change
    add_column :assets, :description, :text
  end
end
