Rails.application.routes.draw do

  get '/terms' => 'static_pages#terms'
  get '/help' => 'static_pages#help'
  get '/contact' => 'static_pages#contact'
  # get 'offers/:id/send_winner_email', to: 'offers#send_winner_email', as: :send_winner_email

  resources :categories do
    resources :products, except: [:index, :new, :create, :show]
  end

  get 'products' => 'products#index', as: :products
  get 'products/:id' => 'products#show', as: :product
  get 'product/new' => 'products#new', as: :new_product
  post 'products' => 'products#create'

  get 'procurements/archive' => 'procurements#archive', as: :expired_procurements
  get 'procurements/best_offers' => 'procurements#best_offers', as: :best_offers
  resources :procurements do
    put :set_best_offer
  end

  # Depracated. Remove these routes and views
  # get 'guest/procurements' => 'visitors#index', as: :visitor_procurements
  # get '/guest/procurements/:id' => 'visitors#show', as: :visitor_procurement

  get '/users/:id/procurements/:procurement_id/products/:product_id/offers/new' => 'offers#new', as: :new_offer

  root :to => "visitors#home"
  devise_for :users
  resources :users do
    resources :offers, except: [:new] do
      get :send_winner_email, on: :member
      get :index_old, on: :collection
      put :update_tech_eval
    end
  end
end