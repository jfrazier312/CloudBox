class CreateSharedAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :shared_assets do |t|
      t.belongs_to :asset
      t.belongs_to :user

      t.timestamps
    end

  end
end
