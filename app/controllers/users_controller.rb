class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy, :add_friend, :remove_friend]
  before_action :check_logged_in_user, only: [:show, :index, :edit]
  before_action :check_current_user, only: [:edit, :update]
  before_action :check_admin_user, only: [:destroy]

  def index
    @users = User.all.paginate(page: params[:page], per_page: 10)
  end

  def show
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
    @assets = @user.assets.all
    set_shared_assets
    set_shared_with_you_assets
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User successfully created"
      redirect_to login_path
    else
      flash.now[:danger] = "User cannot be saved"
      render new_user_path
    end

  end

  def update
    if user_params[:password].blank? && !current_user?(@user)
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    if @user.update(user_params)
      flash[:success] = "User updated successfully"
      redirect_to @user
    else
      flash[:danger] = "Unable to edit user"
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted"
    else
      flash.now[:danger] = "user cannot be deleted"
    end
    redirect_to users_path
  end

  def add_friend
    begin
      current_user.add_friend(@user)
      current_user.save!
      flash[:success] = "Added friend: #{@user.username}"
      redirect_back(fallback_location: users_path)
    rescue Exception => e
      flash[:danger] = e.message
      redirect_back(fallback_location: users_path)
    end
  end

  def remove_friend
    begin
      current_user.remove_friend(@user)
      current_user.save!
      flash[:success] = "Removed friend: #{@user.username}"
      redirect_back(fallback_location: users_path)
    rescue Exception => e
      flash[:danger] = e.message
      redirect_back(fallback_location: users_path)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_shared_assets
    @shared_assets = @user.get_all_shared_assets
  end

  def set_shared_with_you_assets
    shared_with_me = current_user.get_all_shared_assets
    users_shared = @user.assets
    @shared_with_you_assets = shared_with_me & users_shared
    # @shared_with_you_assets = SharedAsset.where(user_id: current_user.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.fetch(:user, {}).permit(:username, :email, :password, :password_confirmation, :privilege)
  end
end
