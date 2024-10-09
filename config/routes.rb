Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items
  get 'shareds/index'
  get 'items/index'
end
