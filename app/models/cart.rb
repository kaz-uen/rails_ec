# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  # カート内の合計金額
  def total
    cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  # カート内の全商品の合計数量  ← レビュワー指摘の場所
  def items_count
    cart_items.sum(:quantity)
  end
end
