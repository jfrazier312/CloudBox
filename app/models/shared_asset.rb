class SharedAsset < ApplicationRecord

  belongs_to :asset
  belongs_to :user

  def self.find_shared_with(asset)
    shared_assets = SharedAsset.where(asset_id: asset.id)
    users = []
    if shared_assets
      shared_assets.each do |sa|
        shared_user = User.find(sa.user_id)
        users << shared_user.username if shared_user
      end
      return users
    end
  end

  def self.destroy_previous_shares(asset)
    SharedAsset.where(asset_id: asset.id).destroy_all
  end
end
