class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if user_signed_in?
      @users = User.where.not(id: current_user)
    else
      @users = User.all
    end
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
