require 'rails_helper'

describe CommentsController, type: :controller do

  shared_examples 'must redirected to signin' do
    it 'be redirected to signin' do
      action

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #index' do
    let(:action) { get :index, params:{ post_id: post } }

    context 'when user is not logged in' do
      let(:post) { create :post }

      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      let!(:post) { create :post, user: subject.current_user }
      let(:comment){ create :comment, post: post, user: subject.current_user }

      it 'populates an array of comments' do
        action

        expect(assigns(:comments)).to eq([comment])
      end

      it 'renders the :index view' do
        action

        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #show' do
    let(:action) { get :show, params:{ id: comment } }

    context 'when user is not logged in' do
      let(:comment) { create :comment, user: (create :user, email: 't@t.com') }

      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      let!(:comment) { create :comment, user: subject.current_user }

      it 'assigns the requested comment to @comment' do
        action

        expect(assigns(:comment)).to eq(comment)
      end

      it 'renders the :show template' do
        action

        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #new' do
    let(:post) { create :post }
    let(:action) { get :new, params:{ post_id: post } }

    context 'when user is not logged in' do
      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      it 'assigns a new Comment to @comment' do
        action

        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it 'renders the :new template' do
        action

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'POST #create' do
    let(:post1) { create :post }
    let(:action) { post :create, params:{ comment: attributes_for(:comment), post_id: post1 } }

    context 'when user is not logged in' do
      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      context 'with valid attributes' do
        it 'creates a new comment' do
          expect{
            action
          }.to change(Comment, :count).by(1)
        end

        it 'redirects to the show page' do
          action

          expect(response).to redirect_to(Comment.last)
        end
      end

      context 'with invalid attributes' do
        let(:action) { post :create, params:{ comment: attributes_for(:invalid_comment), post_id: post1 } }

        it 'does not create the new comment' do
          expect{
            action
          }.to_not change(Comment, :count)
        end

        it 're-renders the :new template' do
          action

          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:comment) { create :comment, user: (create :user, email: 't@t.com') }
    let(:action) { put :update, params:{ id: comment } }

    context 'when user is not logged in' do
      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      let(:comment) { create :comment, user: subject.current_user }

      context 'valid attributes' do
        let(:action) { put :update, params:{ id: comment, comment:{ body: 'abcde' } } }

        it 'changes comment attributes' do
          action

          comment.reload

          expect(comment.body).to eq 'abcde'
        end

        it "redirects to the updated comment" do
          action

          expect(response).to redirect_to(comment)
        end
      end

      context 'with invalid attributes' do
        let(:action) { put :update, params:{ id: comment, comment:{ body: nil } } }
        let(:old_comment) { comment.body }
        it 'does not change comment attributes' do
          action

          comment.reload

          expect(comment.body).to eq old_comment
        end

        it "re-render the edit view" do
          action

          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:action) { delete :destroy, params:{ id: comment } }

    context 'when user is not logged in' do
      let(:comment) { create :comment, user: (create :user, email: 't@t.com') }

      include_examples 'must redirected to signin'
    end

    context 'when user is logged in' do
      sign_in

      let!(:comment) { create :comment, user: subject.current_user }
      it 'deletes the comment' do
        expect{
          action
        }.to change(Comment,:count).by(-1)
      end

      it 'redirects to posts#index' do
        action

        expect(response).to redirect_to(redirect_to user_posts_url(subject.current_user))
      end
    end
  end
end
