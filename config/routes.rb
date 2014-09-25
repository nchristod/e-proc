Rails.application.routes.draw do
  # resources :offers

  resources :categories do 
    resources :products, except: [:index, :new, :create, :show]
  end

  get 'products' => 'products#index', as: :products
  get 'products/:id' => 'products#show', as: :product
  get 'product/new' => 'products#new', as: :new_product
  post 'products' => 'products#create'

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
