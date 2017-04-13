class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.references :user_1
      t.references :user_2

      t.timestamps
    end

    add_index :friends, [:user_1_id, :user_2_id], :unique => true
  end
end
