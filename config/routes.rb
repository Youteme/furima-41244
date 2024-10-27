Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :orders, only: [:index, :create]
  end
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

end
