require 'rails_helper'

describe User, type: :model do
  let(:user) { create :another_user }
  let(:user_to_follow) { create :another_user, email: 't@t.com' }
  let!(:post) { create :post, user: user_to_follow }

  describe '.follow' do
    it 'must follow user' do
      user.follow(user_to_follow.id)

      expect(user.following['users'].include?(user_to_follow.id)).to eq true
    end
  end

  describe '.unfollow' do
    it 'must unfollow user' do
      user.following['users'] << user_to_follow.id

      user.unfollow(user_to_follow.id)

      expect(user.following['users'].include?(user_to_follow.id)).to eq false
    end
  end

  describe '.following_users_posts' do
    it 'must get all posts of followings users' do
      user.follow(user_to_follow.id)

      posts = user.following_users_posts

      expect(posts[0].first.id).to eq user_to_follow.posts[0].id
    end
  end

  describe '.search' do
    it 'must search a user by name' do
      user_name = user.name
      
      user_finded = User.search(user_name)

      expect(user_finded.first.name).to eq user_name
    end
  end
end
