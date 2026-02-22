# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :product_id, uniqueness: { scope: :cart_id }

  def validate_stock!
    product.lock!
    raise ActiveRecord::RecordInvalid, product if product.stock_quantity < quantity
  end

  def add_to_order!(order)
    order.order_items.create!(
      product_name: product.name,
      price_at_purchase: product.price,
      quantity:
    )
    product.reduce_stock!(quantity)
  end
end
