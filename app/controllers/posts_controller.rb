class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_logged_in_user
  before_action :check_post_is_mine_or_admin, only: [:edit, :update, :destroy]

  def new
    @post = current_user.posts.build
  end

  def index
    unless logged_in?
      redirect_to root_path
    end
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Post saved!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Post cannot be saved!"
      render :new
    end
  end

  def update
    # @post = current_user.posts.build(post_params)

    if @post.update_attributes(post_params)
      redirect_to @post
      flash[:success] = "Post updated"
    else
      flash.now[:danger] = "Unable to edit post"
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path
      flash[:success] = "Post Deleted"
    else
      flash.now[:danger] = "Cannot delete post"
      render @post
    end
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.fetch(:post, {}).permit(:image, :caption)
  end
end
