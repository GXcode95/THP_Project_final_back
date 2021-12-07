Rails.application.routes.draw do
  resources :rents
  resources :images
  devise_for :users
  resources :tags
  resources :packages
  resources :games
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
