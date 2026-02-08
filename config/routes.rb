# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products, only: %i[index show] do
    member do
      post 'add_to_cart'
    end
  end
  root 'products#index'

  resource :cart, only: [:show] do
    delete 'remove_item/:product_id', to: 'carts#destroy_item', as: :remove_item
  end

  namespace :admin do
    resources :products, except: [:show]
  end
end
