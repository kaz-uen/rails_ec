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
end
