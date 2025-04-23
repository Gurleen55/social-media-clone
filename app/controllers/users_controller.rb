class UsersController < ApplicationController
  def index
    @users = User.includes(:following, :following).all
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to users_path, notice: "You are now following #{@user.username}."
  end
end
