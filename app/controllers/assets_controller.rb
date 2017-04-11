class AssetsController < ApplicationController

  before_action :check_logged_in_user
  before_action :set_all_assets, only: [:index]
  before_action :set_user
  before_action :set_specific_asset, only: [:show, :edit, :update, :destroy, :get]
  before_action :check_file_is_mine_or_admin

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
      if @asset.save
        format.html { redirect_to user_assets_path  }
        format.json { render user_assets_path, status: :created, location: @asset }
      else
        flash[:danger] = "File could not be saved (All fields are required, max file size is 10MB)"
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

  def get
    if @asset
      send_file @asset.uploaded_file.path, :type => @asset.uploaded_file_content_type
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_all_assets
    set_user
    @assets = @user.assets.paginate(page: params[:page], per_page: 10)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_specific_asset
    set_user
     @asset = @user.assets.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def asset_params
    params.require(:asset).permit(:user_id, :uploaded_file, :filename, :custom_name, :description)
  end
end
