require 'rails_helper'

describe User, type: :model do
  let(:user) { create :another_user }
  let(:user_to_follow) { create :another_user, email: 't@t.com' }
  let!(:post) { create :post, user: user_to_follow }

  it 'must follow user' do
    user.follow(user_to_follow.id)

    expect(user.following['users'].include?(user_to_follow.id)).to eq true
  end

  it 'must unfollow user' do
    user.following['users'] << user_to_follow.id

    user.unfollow(user_to_follow.id)

    expect(user.following['users'].include?(user_to_follow.id)).to eq false
  end

  it 'must get all posts of followings users' do
    user.follow(user_to_follow.id)

    posts = user.following_users_posts

    expect(posts[0].first.id).to eq user_to_follow.posts[0].id
  end
end
