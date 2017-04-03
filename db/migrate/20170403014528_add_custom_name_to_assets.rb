class AddCustomNameToAssets < ActiveRecord::Migration[5.0]
  def change
    add_column :assets, :custom_name, :string
  end
end
