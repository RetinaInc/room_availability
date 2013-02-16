Reservation::Application.routes.draw do  
  get "availability/index"

  post "availability/search"

  root :to => 'availability#index'

end
