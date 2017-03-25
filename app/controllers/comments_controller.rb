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
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash.now[:danger] = "Cannot create comment"
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    # if Comment.destroy(@comment)
    if comment_is_mine?(@comment)
      @comment.delete
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
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
