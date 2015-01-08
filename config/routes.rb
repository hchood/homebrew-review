Rails.application.routes.draw do
  devise_for :users

  root "homebrews#index"
end
