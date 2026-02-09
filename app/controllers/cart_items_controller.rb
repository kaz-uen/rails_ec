# frozen_string_literal: true

class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0 # 一覧画面からの場合は1

    add_product_to_cart(product.id, quantity)
    redirect_back(fallback_location: root_path, notice: 'カートに追加しました。')
  end

  def destroy
    remove_from_cart(params[:product_id])
    redirect_to cart_path, notice: 'カートから削除しました。'
  end
end
