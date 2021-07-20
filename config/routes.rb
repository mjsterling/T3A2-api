Rails.application.routes.draw do
  post '/users', to: 'users#create'
  patch '/users/:id', to: 'users#update'
  post '/login', to: 'users#login'

  get '/bookings', to: 'bookings#index'
  get '/bookings/:id', to: 'bookings#show'
  post '/bookings', to: 'bookings#create'
  patch '/bookings/:id', to: 'bookings#update'

  get '/rooms', to: 'rooms#index'
  get '/rooms/:id', to: 'rooms#show'
  post '/rooms', to: 'rooms#create'
  patch '/rooms/:id', to: 'rooms#update'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
