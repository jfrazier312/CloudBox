class Addfilenametoassets < ActiveRecord::Migration[5.0]
  def change
    add_column :assets, :filename, :string
  end
end
