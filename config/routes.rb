# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products, only: %i[index show]
  root 'products#index'

  resource :cart, only: [:show]
  resources :cart_items, only: %i[create destroy], param: :product_id
  resources :checkouts, only: [:create]

  namespace :admin do
    resources :products, except: [:show]
    resources :orders, only: %i[index show]
  end

  # 開発環境のみ /letter_opener で送信済みメールを確認可能にする
  if Rails.env.development?
    # require 'letter_opener_web'
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
