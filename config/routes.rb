Rails.application.routes.draw do
  get "users/account"
  get "users/profile"
  get 'homes/top'
  get 'homes/tokyo'
  get 'homes/nagoya'
  get 'homes/osaka'
  get 'homes/hakodate'
  get 'homes/search'

  devise_for :users
  resources :users
  resources :products

  resources :reservations, only: [:create, :index, :show, :destroy] do
    collection do
      post 'confirmation', to: 'reservations#confirmation'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "homes#top"
end
