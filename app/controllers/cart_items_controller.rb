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

  private

  def add_product_to_cart(product_id, quantity = 1)
    product = Product.find(product_id)
    cart_item = current_cart.cart_items.find_or_initialize_by(product_id: product.id)

    if cart_item.new_record?
      # 新規作成時は、そのまま数量を設定
      cart_item.quantity = quantity
    else
      # 既存レコードの場合は、既存数量に追加
      cart_item.quantity += quantity
    end

    cart_item.save!
  end

  def remove_from_cart(product_id)
    current_cart.cart_items.where(product_id:).destroy_all
  end
end
