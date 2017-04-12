module AssetsHelper

  def check_file_is_mine_or_admin
    unless current_user == User.find(params[:user_id]) || current_user.privilege_admin?
      flash[:danger] = "You do not have permission to perform this action"
      redirect_to root_path
    end
  end

end
