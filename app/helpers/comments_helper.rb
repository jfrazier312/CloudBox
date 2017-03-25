module CommentsHelper

  def comment_is_mine?(comment)
    comment.user_id == current_user.id
  end

end
