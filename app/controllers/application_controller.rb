# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_cart, :cart_items, :cart_total, :cart_items_count

  private

  def cart_items_count
    current_cart.values.sum
  end

  def current_cart
    @current_cart ||= session[:cart] || {}
    session[:cart] = @current_cart
    @current_cart
  end

  def add_product_to_cart(product_id, quantity = 1)
    cart = current_cart
    product_id_str = product_id.to_s
    cart[product_id_str] = (cart[product_id_str] || 0) + quantity
    session[:cart] = cart
  end

  def remove_from_cart(product_id)
    cart = current_cart
    cart.delete(product_id.to_s)
    session[:cart] = cart
  end

  def cart_items
    return [] if current_cart.empty?

    product_ids = current_cart.keys.map(&:to_i)
    products = Product.where(id: product_ids).index_by(&:id)

    current_cart.map do |product_id, quantity|
      product = products[product_id.to_i]
      next unless product

      {
        product:,
        quantity: quantity.to_i
      }
    end.compact
  end

  def cart_total
    cart_items.sum { |item| item[:product].price * item[:quantity] }
  end
end
