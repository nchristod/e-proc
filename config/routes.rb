Rails.application.routes.draw do
  resources :offers

  resources :categories

  resources :products

  resources :procurements

  root :to => "visitors#index"
  devise_for :users
  resources :users
end
