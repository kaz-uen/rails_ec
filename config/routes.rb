# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products, only: %i[index show]
  root 'products#index'

  resource :cart, only: [:show]
  resources :cart_items, only: %i[create destroy], param: :product_id

  namespace :admin do
    resources :products, except: [:show]
  end
end
