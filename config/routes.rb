Rails.application.routes.draw do
  devise_for :users

  root "homebrews#index"

  resources :users, only: [] do
    resources :homebrews, only: [:new, :create]
  end
end
