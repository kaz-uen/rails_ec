# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart_items = cart_items
    @cart_total = cart_total
  end

  def destroy_item
    remove_from_cart(params[:product_id])
    redirect_to cart_path, notice: 'カートから削除しました。'
  end
end
