# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.with_attached_image.all
  end

  def show
    @product = Product.find(params[:id])
    # 最新の登録商品を4件取得（現在の商品を除く）
    @related_products = Product.with_attached_image.where.not(id: @product.id).order(created_at: :desc).limit(4)
  end
end
