Rails.application.routes.draw do
  root "home#index"

  resources :users, only: [:create, :show] do
    resources :discover, only: [:index], controller: "user_discover"
    resources :movies, only: [:index], controller: "user_movies"
  end

  get '/register', to: 'users#new'
end