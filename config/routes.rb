Rails.application.routes.draw do
  # resources :offers

  resources :categories do 
    resources :products
  end

  get 'products' => 'products#index', as: :products

  resources :procurements
  # get 'procurements' => 'procurements#index', as: :procurements
  get 'guest/procurements' => 'visitors#index', as: :visitor_procurements
  get '/guest/procurements/:id' => 'visitors#show', as: :visitor_procurement

  root :to => "visitors#home"
  devise_for :users
  resources :users do
    # resources :procurements
    resources :offers
  end
end
