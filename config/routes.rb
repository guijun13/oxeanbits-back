Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :movies, only: [:index, :new, :create]
  resources :user_movies, only: [:create, :update]
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/users', to: 'users#index'
  post '/users', to: 'users#create'

  get '/movies', to: 'movies#index'
  post '/movies', to: 'movies#create'

  get '/user_movies', to: 'user_movies#index'
  post '/user_movies', to: 'user_movies#create'
  patch '/user_movies', to: 'user_movies#update'
  
  delete '/logout', to: 'sessions#destroy'

  root 'sessions#new'
end
