require 'rails_helper'

describe 'routing to users', type: :routing do
  it 'routes /follow' do
    expect(get: '/users/1/follow').to route_to(
      controller: 'users',
      action: 'follow',
      user_id: '1'
      )
  end

  it 'routes /unfollow' do
    expect(get: '/users/1/unfollow').to route_to(
      controller: 'users',
      action: 'unfollow',
      user_id: '1'
      )
  end

  it 'routes /index' do
    expect(get: '/users').to route_to(
      controller: 'users',
      action: 'index',
      )
  end
end
