Rails.application.routes.draw do
  
  get 'procurements/best_offers' => 'procurements#best_offers', as: :best_offers

  resources :categories do 
    resources :products, except: [:index, :new, :create, :show]
  end

  get 'products' => 'products#index', as: :products
  get 'products/:id' => 'products#show', as: :product
  get 'product/new' => 'products#new', as: :new_product
  post 'products' => 'products#create'

  get 'procurements/archive' => 'procurements#archive', as: :expired_procurements
  resources :procurements

  # Depracated. Remove these routes and views
  # get 'guest/procurements' => 'visitors#index', as: :visitor_procurements
  # get '/guest/procurements/:id' => 'visitors#show', as: :visitor_procurement

  get '/users/:id/procurements/:procurement_id/products/:product_id/offers/new' => 'offers#new', as: :new_offer

  root :to => "visitors#home"
  devise_for :users
  resources :users do
    resources :offers, except: [:new]
  end
end