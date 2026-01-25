# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image

  before_save :set_is_on_sale

  private

  def set_is_on_sale
    # original_priceが存在し、かつpriceより大きい場合にセールフラグをtrueにする
    self.is_on_sale = original_price.present? && original_price > price
  end
end
