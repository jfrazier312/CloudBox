class AssetsController < ApplicationController
  before_action :set_all_assets, only: [:index]
  before_action :set_user
  before_action :set_specific_asset, only: [:show, :edit, :update, :destroy]
  before_action :check_logged_in_user


  # GET /assets
  # GET /assets.json
  def index
  end


  # GET /assets/1
  # GET /assets/1.json
  def show
  end

  # GET /assets/new
  def new
    @asset = @user.assets.new
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = @user.assets.new(asset_params)

    respond_to do |format|
      if @asset.save!
        format.html { redirect_to user_assets_path  }
        format.json { render user_assets_path, status: :created, location: @asset }
      else
        format.html { render :new }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update

    respond_to do |format|
      if @asset.update_attributes(asset_params)
        format.html { redirect_to user_assets_path  }
        format.json { render :show, status: :ok, location: @asset }
      else
        format.html { render :edit }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy

    @asset.destroy
    respond_to do |format|
      format.html { redirect_to user_assets_path  }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_all_assets
    @assets = current_user.assets.all
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_specific_asset
    @user = User.find(params[:user_id])
    @asset = current_user.assets.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def asset_params
    params.require(:asset).permit(:user_id, :uploaded_file, :filename)
  end
end
