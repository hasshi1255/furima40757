Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :items do
    resources :purchases, only: [:index, :create] 
  end

  
  root to: 'items#index'
  
end
