# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.with_attached_image.all
  end

  def show
    @product = Product.find(params[:id])
    # 最新の登録商品を4件取得（現在の商品を除く）
    @related_products = Product.with_attached_image.where.not(id: @product.id).order(created_at: :desc).limit(4)
  end

  def add_to_cart
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0 # 一覧画面からの場合は1

    add_product_to_cart(product.id, quantity)
    redirect_back(fallback_location: root_path, notice: 'カートに追加しました。')
  end
end
