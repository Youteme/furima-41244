Rails.application.routes.draw do
  root to: "items#index"
  get 'shareds/index'
  get 'items/index'
end
