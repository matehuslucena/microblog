require 'rails_helper'

describe UsersController, type: :controller do
  shared_examples 'must redirected to signin' do
    it 'be redirected to signin' do
      action

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #index' do
    it 'must render the index view' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #follow' do
    let(:user) { create :another_user }
    let(:action) { get :follow, params:{user_id: user} }

    context 'when user is not logged in' do
      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      it 'let the user follow another user' do
        action

        expect(response).to redirect_to(users_path)
      end
    end
  end

  describe 'GET #unfollow' do
    let(:user) { create :another_user }
    let(:action) { get :unfollow, params:{user_id: user} }

    context 'when user is not logged in' do
      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      it 'let the user unfollow another user' do
        action

        expect(response).to redirect_to(users_path)
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create :another_user }

    it 'must render show view' do
      get :show, params:{ id: user }

      expect(response).to render_template(:show)
    end
  end
end
