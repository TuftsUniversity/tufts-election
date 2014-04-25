ALLOW_DOTS ||= /[a-zA-Z0-9_\-.:]+/

TuftsElection::Application.routes.draw do


  Blacklight.add_routes(self)

  root :to => "catalog#index"

  devise_for :users

  match '/catalog/:id/track', :to => 'catalog#track', :constraints => {:id => /.*/}, :as =>'catalog'
  resources :catalog, :id => ALLOW_DOTS
  resources :candidates, :only=>'index'
  resources :message_queues, :only=>'index'
end
