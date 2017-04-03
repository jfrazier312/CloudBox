class CreateUserAssetTable < ActiveRecord::Migration[5.0]
  def change
    create_table :user_assets do |t|

    end
    add_reference :user_assets, :assets, foreign_key: true
    add_reference :user_assets, :users, foreign_key: true
  end
end
