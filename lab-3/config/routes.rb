Rails.application.routes.draw do


  root 'index#index'
  get '/profile', to: 'application#show'

  get '/register', to: 'register#new'
  post '/register', to: 'drivers#create'
  post '/register', to: 'passengers#create'
  
  get '/my_trips', to: 'trips#my_trips'
  get '/available_trips', to: 'trips#available_trips'
  get '/finish_trip', to: 'trips#finish_trip'
  post '/pay_trip', to: 'trips#pay_trip'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'

  resources :drivers
  resources :passengers
  resources :trips

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
