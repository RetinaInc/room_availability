Reservation::Application.routes.draw do  
  get "availability/index"

  get "availability/search"

  root :to => 'availability#index'

end
