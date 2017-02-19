class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  def follow user_id
    self.following = { 'users': [] } unless self.following
    self.following['users'] << user_id
    self.save
  end

  def unfollow user_id
    self.following['users'].delete(user_id)
    self.save
  end

  def get_following_posts
    self.following['users'].each do |user_id|
      following_posts = Post.where(user_id: user_id)
    end
  end
end
