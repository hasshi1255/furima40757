Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :items do
    resources :orders, only: [:new, :create]
  end
  
  root to: 'items#index'
  
end
