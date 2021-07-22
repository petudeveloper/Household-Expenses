Rails.application.routes.draw do
  resources :expenses
  resources :groups
  root to: "users#show"

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
