Rails.application.routes.draw do
  root 'users#show'
  resources :expenses, only: [:index, :show, :new, :create]
  resources :groups, only: [:index, :show, :new, :edit, :create, :update]
  resources :user, only: [:show]

  devise_for :users, :controllers => {
    registrations: 'registrations'
  }

  get 'expenses/expenses/external', to: 'expenses#external'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
