require 'rails_helper'

describe 'routing to posts', type: :routing do
  it 'routes posts#index' do
    expect(get: '/users/1/posts').to route_to(
      controller: 'posts',
      action: 'index',
      user_id: '1'
      )
  end

  it 'routes posts#create' do
    expect(post: '/users/1/posts').to route_to(
      controller: 'posts',
      action: 'create',
      user_id: '1'
      )
  end

  it 'routes posts#new' do
    expect(get: '/users/1/posts/new').to route_to(
      controller: 'posts',
      action: 'new',
      user_id: '1'
      )
  end

  it 'routes posts#edit' do
    expect(get: '/posts/1/edit').to route_to(
      controller: 'posts',
      action: 'edit',
      id: '1'
      )
  end

  it 'routes posts#show' do
    expect(get: '/posts/1').to route_to(
      controller: 'posts',
      action: 'show',
      id: '1'
      )
  end

  it 'routes posts#update' do
    expect(put: '/posts/1').to route_to(
      controller: 'posts',
      action: 'update',
      id: '1'
      )
  end

  it 'routes posts#destroy' do
    expect(delete: '/posts/1').to route_to(
      controller: 'posts',
      action: 'destroy',
      id: '1'
      )
  end
end
