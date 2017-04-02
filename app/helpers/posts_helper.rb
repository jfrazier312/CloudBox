module PostsHelper

  def check_post_is_mine_or_admin
    unless current_user == Post.find(params[:id]).user || current_user.privilege_admin?
      flash[:danger] = "Cannot alter this post"
      redirect_to @post
    end
  end

  def current_user_owns_post?
    current_user == Post.find(params[:id]).user || current_user.privilege_admin?
  end

  def form_image_select(post)
    return image_tag post.image.url(:medium),
                     id: 'image-preview',
                     class: 'img-responsive' if post.image.exists?
    # image_tag 'placeholder.jpg', id: 'image-preview', class: 'img-responsive'
  end

  def display_likes(post)
    votes = post.votes_for.up.by_type(User)
    if votes.size >= 9
      return count_likers(post)
    end
    list_likers(post)
  end

  def count_likers(post)
    votes = post.votes_for.up.by_type(User)
    return votes.size.to_s + ' people like this'
  end


  def list_likers(post)
    votes = post.votes_for.up.by_type(User)
    usernames = []
    unless votes.blank?
      votes.voters.each do |voter|
        usernames.push(link_to voter.username,
                                user_path(voter.username),
                                class: 'user-name')
      end
      usernames.to_sentence.html_safe + like_plural(votes)
    end
  end

  def user_liked_post?(post)
    current_user.voted_for? post
  end

  def liked_post(post)
    return 'glyphicon-heart' if current_user.voted_for? post
    'glyphicon-heart-empty'
  end

  private

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end

end
