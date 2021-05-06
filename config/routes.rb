Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :credit_cards
  resources :transactions, only: [:index, :create, :show]
  resources :accounts, only: [:index, :create, :show]
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
