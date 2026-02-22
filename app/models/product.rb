# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image

  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }

  before_save :set_is_on_sale

  def reduce_stock!(quantity)
    update!(stock_quantity: stock_quantity - quantity)
  end

  private

  def set_is_on_sale
    # original_priceが存在し、かつpriceより大きい場合にセールフラグをtrueにする
    self.is_on_sale = original_price.present? && original_price > price
  end
end
