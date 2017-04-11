class CreateSharedAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :shared_assets do |t|
      t.belongs_to :asset
      t.belongs_to :user

      t.timestamps
    end

    add_index :shared_assets, [:asset_id, :user_id], :unique => true

  end


end
