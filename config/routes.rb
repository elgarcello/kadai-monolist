Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'rankings/want', to: 'rankings#want'

  
  resources :users, only: [:show, :new, :create]
  resources :items, only: [:new, :show]
  resources :ownerships, only: [:create, :destroy]
end
