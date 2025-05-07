class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    @users = User.includes(:following, :followers).all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments)
    @followers = @user.followers.includes(:posts)
    @following = @user.following.includes(:posts)
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
