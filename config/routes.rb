Reservation::Application.routes.draw do  
  get "availability/search"

  root :to => 'availability#search'

end
