Rails.application.routes.draw do
  get 'friendships/index'
  get 'friendships/create'
  get 'friendships/update'
  get 'friendships/destroy'
  resources :posts
  devise_for :users, controllers: { registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords'
  }
  resources :users, only: %i[ show index] do
    resources :follows, only: %i[ index create destroy]
    resources :friendships, only: %i[ create update destroy ]
    resources :posts, only: %i[ show index edit update destroy] do 
      resources :comments, only: %i[ index edit update destroy]
  end
end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
