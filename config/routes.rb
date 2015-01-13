Rails.application.routes.draw do
  devise_for :users

  root "homebrews#index"

  resources :users, only: [:index, :show] do
    resources :friendships, only: :create
  end

  resources :friendships, only: :destroy

  resources :homebrews, only: [:index, :show, :new, :create] do
    resources :reviews, only: :create
  end

  namespace :api do
    api_version(
      :module => "V1",
      :header => {:name => "Accept",
      :value => "application/vnd.mycompany.com; version=1"},
      :defaults => {:format => :json},
      default: true
    ) do
      resources :homebrews, only: [:index, :show, :create]
      resources :users, only: [:index, :show]
    end
  end
end
