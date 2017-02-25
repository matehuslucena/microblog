class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:search] && !params[:search].empty?
      @users = User.search(params[:search]).where.not(id: current_user)
    elsif user_signed_in?
      @users = User.where.not(id: current_user)
    else
      @users = User.all
    end

  end

  def follow
    current_user.follow(params[:user_id])

    redirect_to users_path, notice: 'Success follow!'
  end

  def unfollow
    current_user.unfollow(params[:user_id])

    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
  end
end
