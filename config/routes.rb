Rails.application.routes.draw do
  devise_for :users

  root "homebrews#index"

  resources :users, only: [:index, :show]
  resources :homebrews, only: [:index, :show, :new, :create]
end
