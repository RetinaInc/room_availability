Reservation::Application.routes.draw do  
  get "availability/index"

  post "availability/search", :as => :search

  root :to => 'availability#index'

end
