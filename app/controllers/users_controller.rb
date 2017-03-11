class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_logged_in_user, only: [:show, :index, :edit]
  before_action :check_current_user, only: [:show, :edit, :update]

  def index
    @users = User.all.paginate(page: params[:page], per_page: 10)
  end

  def show
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.fetch(:user, {}).permit(:username, :email, :password, :password_confirmation, :privilege)
  end
end
