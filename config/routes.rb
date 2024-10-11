Rails.application.routes.draw do
 
  root to: "items#index"
  resources :items
  get 'shareds/index'
  get 'items/index'
end
