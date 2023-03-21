Rails.application.routes.draw do\
 root "home#index"

 resources :users, only: [:create, :show]

#  resources :register, only: [:new]

 get '/register', to: 'users#new'
end
