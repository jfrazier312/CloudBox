class SharedAssetsController < ApplicationController

  before_action :set_asset

  def new

  end


  def create


  end


  private

  def shared_assets_params
    params.required(:shared_asset).permit(:user_list)
  end

  def set_asset
    @asset = Asset.find(params[:id])
  end
end
