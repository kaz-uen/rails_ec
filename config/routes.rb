# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products, only: [:index]
  root 'products#index'
end
