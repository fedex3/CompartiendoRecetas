Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "recipes#index"

  #devise_for :users, controllers: {
  #  sessions: 'users/sessions'
  #}

  resources :recipes do
    post 'like', to: 'likes#create', as: :like
    delete 'unlike', to: 'likes#destroy', as: :unlike
    post 'save', to: 'saves#create', as: :save
    delete 'remove_from_saved', to: 'saves#destroy', as: :remove_from_saved
  end

  get	'/perfil', to:	'users#show', as: 'user_profile'
  get	'/perfil/edit', to:	'users#edit', as:'edit_user'
  put '/perfil', to:	'users#update'

  resources 'perfil', controller: "users"

 # get 'mis-ingredientes', to: 'pantry_items#index'
  #post 'mis-ingredientess/new'
  resources "mis_ingredientes", controller: "pantry_items"

  resources :ingredients

  post 'search', to: 'search#index', as: 'search'
  post 'search/suggestions', to: 'search#suggestions', as: 'search_suggestions'
  get 'ai_recipe', to: 'recipes#ai_recipe'

  #get '/ingredients', to: 'ingredients#index'

  get '/my-recipes', to: 'recipes#mine'
  #get '/ingredients/list'

  #get 'ingredients/new', to: 'ingredients#new'


end
