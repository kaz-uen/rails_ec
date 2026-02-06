# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products, only: %i[index show]
  root 'products#index'

  namespace :admin do
    resources :products, except: [:show]
  end
end
