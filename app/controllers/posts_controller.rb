
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :create, :new, :show]

  def index
    @posts = Post.all.where(user_id: current_user.id)
    @user.following_users_posts.each do |user_id|
      user_posts = Post.where(user_id: user_id)
      @posts = user_posts.or(@posts)
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to user_posts_url(current_user), notice: 'Post was successfully destroyed.'
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    def post_params
      params.require(:post).permit(:user_id, :body)
    end
end
