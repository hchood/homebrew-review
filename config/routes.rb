Rails.application.routes.draw do
  devise_for :users

  root "homebrews#index"

  resources :homebrews, only: [:show, :new, :create]
end
