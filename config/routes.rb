Rails.application.routes.draw do

  #Gossip Project
    #Home
    get '/gossip_project/home', to: 'gossip_project#home'

    #Welcome
    get '/gossip_project/welcome/:name', to: 'gossip_project#welcome'

    #Nav links
    get '/gossip_project/team', to: 'gossip_project#team'
    get '/gossip_project/contact', to: 'gossip_project#contact'

  #Gossips
    resources :gossips do
      resources :comments
    end

  #Users
    resources :users

  #Cities
    resources :cities, only: [:show]

end


#resources :gossips =

  #get '/gossips', to: 'gossips#index'
  #get '/gossips/:id', to: 'gossips#show'
  #get '/gossips/new', to: 'gossips#new'
  #post '/gossips', to: 'gossips#create'  # reçoit de l'info d'un formulaire donc verbe POST
  #get '/gossips/:id/edit', to: 'gossips#edit'
  #put '/gossips/:id', to: 'gossips#update' # reçoit de l'info d'un formulaire donc verbe PUT
  #delete '/gossips/:id', to: 'gossips#destroy' # une requête un peu spéciale pour supprimer donc verbe DELETE
