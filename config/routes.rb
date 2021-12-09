Rails.application.routes.draw do
  root to: 'games#index'
  namespace :api do
    resources :users, only: [:show, :update]
    devise_for :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
    namespace :admin do
      resources :users, only: [:index, :show]
      resources :rents, only: [:index]
      resources :games, only: [:index, :show, :create, :update, :destroy] do
        resources :images, only: [:create, :destroy]
      end
    end
    resources :games
    resources :images
    resources :carts
    resources :orders
    resources :packages
    resources :rents
  end
  # features
  # resources :tags
  # resources :ranks
  # resources :comments
  # resources :favorites
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
