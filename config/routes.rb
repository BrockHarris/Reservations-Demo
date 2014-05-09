Restaurants::Application.routes.draw do
 
  root :to => 'reservations#index'

  resources :reservations
end
