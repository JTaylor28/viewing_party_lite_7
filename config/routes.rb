Rails.application.routes.draw do\
 root "home#index"

 resources :users, only: [:create, :show] do
  get "discover", on: :member
 end

#  resources :register, only: [:new], controller: :users

 get '/register', to: 'users#new'
 
 get "users/:id/discover", to: "discover#index"
end
