require 'rails_helper'

describe PostsController, type: :controller do

  shared_examples 'must redirected to signin' do
    it 'be redirected to signin' do
      action

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #index' do
    let(:user) { create :another_user }
    let(:action) { get :index, params:{ user_id: user } }

    context 'when user is not logged in' do
      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in
      let!(:post) { create :post, user: subject.current_user }

      it 'populates an array of posts' do
        action

        expect(assigns(:posts)).to eq([post])
      end

      it 'renders the :index view' do
        action

        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #show' do
    let(:post) { create :post }
    let(:action) { get :show, params:{ id: post } }

    context 'when user is not logged in' do
      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      let!(:post) { create :post, user: subject.current_user }

      it 'assigns the requested post to @post' do
        action

        expect(assigns(:post)).to eq(post)
      end

      it 'renders the :show template' do
        action

        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #new' do
    let(:user) { create :another_user }
    let(:action) { get :new, params:{ user_id: user } }

    context 'when user is not logged in' do
      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      let!(:post) { create :post, user: subject.current_user }

      it 'assigns a new Post to @post' do
        action

        expect(assigns(:post)).to be_a_new(Post)
      end

      it 'renders the :new template' do
        action

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create :another_user }
    let(:action) { post :create, params:{ post: attributes_for(:post), user_id: user } }

    context 'when user is not logged in' do
      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      let(:action) { post :create, params:{ post: attributes_for(:post), user_id: subject.current_user } }

      context 'with valid attributes' do
        it 'creates a new post' do
          expect{
            action
          }.to change(Post, :count).by(1)
        end

        it 'redirects to the show page' do
          action

          expect(response).to redirect_to(Post.last)
        end
      end

      context 'with invalid attributes' do
        let(:action) { post :create, params:{ post: attributes_for(:invalid_post), user_id: subject.current_user } }

        it 'does not create the new post' do
          expect{
            action
          }.to_not change(Post, :count)
        end

        it 're-renders the :new template' do
          action

          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:post) { create :post }
    let(:action) { put :update, params:{ id: post } }

    context 'when user is not logged in' do
      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in
      let!(:post) { create :post, user: subject.current_user }

      context 'valid attributes' do
        let(:action) { put :update, params:{ id: post, post:{ body: 'abcde' } } }

        it 'changes post attributes' do
          action

          post.reload

          expect(post.body).to eq 'abcde'
        end

        it "redirects to the updated contact" do
          action

          expect(response).to redirect_to(post)
        end
      end

      context 'with invalid attributes' do
        let(:action) { put :update, params:{ id: post, post:{ body: nil } } }
        let(:old_post) { post.body }
        it 'does not change post attributes' do
          action

          post.reload

          expect(post.body).to eq old_post
        end

        it "re-render the edit view" do
          action

          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:action) { delete :destroy, params:{ id: post } }

    context 'when user is not logged in' do
      let(:post) { create :post }

      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      let!(:post) { create :post }
      it 'deletes the post' do
        expect{
          action
        }.to change(Post,:count).by(-1)
      end

      it 'redirects to posts#index' do
        action

        expect(response).to redirect_to(redirect_to user_posts_url(subject.current_user))
      end
    end
  end
end
