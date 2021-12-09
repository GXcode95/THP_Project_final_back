Rails.application.routes.draw do
  root to: 'api/games#index'
  namespace :api, as: nil do
    resources :users, only: [:show, :update]
    devise_for :users,
    controllers: {
      sessions: 'api/users/sessions',
      registrations: 'api/users/registrations'
    }
    namespace :admin do
      resources :users, only: [:index, :show]
      resources :rents, only: [:index, :update]
      resources :games, only: [:index, :create, :update, :destroy] do
        resources :images, only: [:create, :destroy]
      end
    end
    resources :games, only: [:index, :show]
    resources :carts, only: [:update] # Add to be update when implementing stripes
    resources :orders, only: [:create, :update, :destroy]
    resources :rents, only: [:index, :create, :update, :destroy]
  end
  # features #
  # resources :tags
  # resources :ranks
  # resources :comments
  # resources :favorites
  # resources :packages
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
