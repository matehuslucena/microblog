require 'rails_helper'

describe 'routing to comments', type: :routing do
  it 'routes comments#index' do
    expect(get: '/posts/1/comments').to route_to(
      controller: 'comments',
      action: 'index',
      post_id: '1'
      )
  end

  it 'routes comments#create' do
    expect(post: '/posts/1/comments').to route_to(
      controller: 'comments',
      action: 'create',
      post_id: '1'
      )
  end

  it 'routes comments#new' do
    expect(get: '/posts/1/comments/new').to route_to(
      controller: 'comments',
      action: 'new',
      post_id: '1'
      )
  end

  it 'routes comments#edit' do
    expect(get: '/comments/1/edit').to route_to(
      controller: 'comments',
      action: 'edit',
      id: '1'
      )
  end

  it 'routes comments#show' do
    expect(get: '/comments/1').to route_to(
      controller: 'comments',
      action: 'show',
      id: '1'
      )
  end

  it 'routes comments#update' do
    expect(put: '/comments/1').to route_to(
      controller: 'comments',
      action: 'update',
      id: '1'
      )
  end

  it 'routes comments#destroy' do
    expect(delete: '/comments/1').to route_to(
      controller: 'comments',
      action: 'destroy',
      id: '1'
      )
  end
end
