Rails.application.routes.draw do
  devise_for :users
  resources :users
  root 'posts#index'



  resources :posts do
    get 'likes'
    resources :comments
  end

  resources :comments do
    resources :comments
  end
end
