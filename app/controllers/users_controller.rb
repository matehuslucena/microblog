class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user)
  end

  def follow
    current_user.follow(params[:user_id])

    redirect_to users_path
  end

  def unfollow
    current_user.unfollow(params[:user_id])

    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
  end
end
