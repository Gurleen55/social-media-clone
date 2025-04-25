class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.includes(:following, :followers).all
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to users_path, notice: "You are now following #{@user.username}."
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to users_path, notice: "You are no longer following #{@user.username}."
  end
end
