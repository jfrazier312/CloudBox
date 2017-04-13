class MakePrivacyDefault0 < ActiveRecord::Migration[5.0]
  def change
    change_column_default :assets, :privacy, 0
  end
end
