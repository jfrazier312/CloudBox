class CommentsController < ApplicationController

  # before_action :set_comment, only: [:destroy]
  before_action :set_post, only: [:create, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "Created comment"
      redirect_to :back
    else
      flash.now[:danger] = "Cannot create comment"
      render posts_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    post = @post

    if Comment.destroy(@comment)
      flash[:success] = "Comment deleted"
      redirect_to post_path(post)
    else
      flash[:danger] = "Cannot delete comment"
      redirect_to post_path(post)
    end
  end


  private

  def comment_params
    params.fetch(:comment, {}).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
