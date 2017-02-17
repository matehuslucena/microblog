Rails.application.routes.draw do
  devise_for :users

  shallow do
    resources :users do
      resources :posts do
        resources :comments
      end
    end
  end

  root to: 'posts#index'
end
