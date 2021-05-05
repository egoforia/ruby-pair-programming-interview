Rails.application.routes.draw do
  resources :credit_cards
  resources :transactions, only: [:index, :create, :show]
  resources :accounts, only: [:index, :create, :show]
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
