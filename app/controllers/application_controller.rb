# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_cart, :cart_items, :cart_total, :cart_items_count

  private

  def current_cart
    @current_cart ||= Cart.find_or_create_by(id: session[:cart_id])

    session[:cart_id] = @current_cart.id
    @current_cart
  end

  def cart_items_count
    current_cart.items_count
  end

  def cart_items
    current_cart.cart_items.includes(:product).map do |item|
      {
        product: item.product,
        quantity: item.quantity
      }
    end
  end

  def cart_total
    current_cart.total
  end

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
