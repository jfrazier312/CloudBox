class SessionsController < ApplicationController

  before_action :check_logged_out_user, only: [:new, :create]

  def new
  end

  def create
    user = User.where(username: params[:session][:username].downcase).take
    if user && user.authenticate(params[:session][:password])
      # Log in and redirect to the user profile page
      log_in user
      redirect_back_or user and return
    else
      # Create an error message with flash.now instead of flash
      flash.now[:danger] = 'Invalid username/password combination'
      render 'new' and return
    end

  end

  def destroy
    log_out
    redirect_to root_url
  end
end
