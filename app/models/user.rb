class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  def follow user_id
    self.following['users'] << user_id
    self.save
  end

  def unfollow user_id
    self.following['users'].delete(user_id)
    self.save
  end

  def following_users_posts
    self.following['users'].map do |user_id|
      Post.where(user_id: user_id)
    end
  end

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
