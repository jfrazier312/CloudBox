class FriendsController < ApplicationController

  before_action :set_user, only: [:index]
  before_action :set_friend, only: [:destroy]

  # TODO: Add security checks, is current user or admin?

  def index
    friends = @user.get_all_friends
    @friends = @user.get_users_from_friends(friends)
  end

  def new

  end

  def create

  end

  def destroy
    @friend.destroy
    # Don't destroy shared assets(?), just don't populate any friends assets shared.
    # @user.assets.where(user_id: @user2.id).destroy_all
    # @user2.assets.where(user_id: @user.id).destroy_all
    flash[:success] = "Friend removed!"
    redirect_to user_friends_path @user
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def friend_params
    params.fetch(:friends, {}).permit(:user_1_id, :user_2_id)
  end

  def set_friend
    set_user
    @user2 = User.find(params[:id])
    @friend = Friend.where(user_1_id: @user.id, user_2_id: @user2.id) | Friend.where(user_1_id: @user2.id, user_2_id: @user.id)
    @friend = @friend.first
  end

end
