# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order

  validates :product_name, :price_at_purchase, :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }
end
