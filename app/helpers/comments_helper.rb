module CommentsHelper

  def comment_is_mine?(comment)
    comment.user_id == current_user.id
  end

  def check_comment_owner(comment)
    comment.user.id == current_user.id
  end


end
