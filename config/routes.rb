Rails.application.routes.draw do
  devise_for :users , :controllers => { registrations: 'users/registrations' }

  shallow do
    resources :users, only: [:index, :show] do
      get 'follow'
      get 'unfollow'
      resources :posts do
        resources :comments
      end
    end
  end

  root to: 'posts#index'
end
