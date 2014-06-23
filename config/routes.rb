Rails.application.routes.draw do
  # resources :offers

  resources :categories do 
    resources :products
  end

  # resources :products

  # resources :procurements
  get 'procurements' => 'visitors#index', as: :procurements
  get 'procurements/:id' => 'visitors#show', as: :procurement

  root :to => "visitors#home"
  devise_for :users
  resources :users do
    resources :procurements
    resources :offers
  end
end
