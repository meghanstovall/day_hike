Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/trips", to: "trips#index"
  get "/trips/:id", to: "trips#show"
  get "/trips/:trip_id/trails/:trail_id", to: "trails#show"
  get "/trails/:trail_id", to: "trails#show"
end
