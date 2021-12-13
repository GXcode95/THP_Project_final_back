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
      resources :tags, only: [:create, :update, :destroy]
    end
    resources :games, only: [:index, :show]
    resources :carts, only: [:show, :index]
    put '/carts_package_update', to: 'carts#package_update'
    resources :packages, only: [:index]
    resources :orders, only: [:create, :update, :destroy]
    resources :rents, only: [:index, :create, :update, :destroy]
    resources :charges, only: [:create]
    resources :tags, only: [:index]
    resources :ranks, only: [:create]
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
