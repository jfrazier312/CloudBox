module PostsHelper

  def check_post_is_mine_or_admin
    unless current_user == Post.find(params[:id]).user || current_user.privilege_admin?
      flash[:danger] = "Cannot alter this post"
      redirect_to @post
    end
  end

  def current_user_owns_post?
    current_user == Post.find(params[:id]).user
  end

end
