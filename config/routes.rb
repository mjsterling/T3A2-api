Rails.application.routes.draw do
  post "/users", to: "users#create"
  patch "/users/:id", to: "users#update"
  post "/login", to: "users#login"

  get "/bookings", to: "bookings#index"
  get "/bookings/:id", to: "bookings#show"
  post "/bookings", to: "bookings#create"
  patch "/bookings/:id", to: "bookings#update"
  delete "/bookings/:id", to: "bookings#delete"

  get "/rooms", to: "rooms#index"
  get "/rooms/:id", to: "rooms#show"
  post "/rooms", to: "rooms#create"
  patch "/rooms/:id", to: "rooms#update"

  get "/requests", to: "requests#index"
  get "/requests/:id", to: "requests#show"
  post "/requests", to: "requests#create"
  patch "/requests/:id", to: "requests#update"
  delete "/requests/:id", to: "requests#delete"
end
