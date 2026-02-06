# frozen_string_literal: true

module Admin
  class ProductsController < BaseController
    layout 'admin'  # 管理者用レイアウトを使用

    before_action :set_product, only: %i[show edit update destroy]

    def index
      @products = Product.all.order(created_at: :desc)
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to admin_products_path, notice: '商品を作成しました。'
      else
        render :new, status: unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path, notice: '商品を更新しました。'
      else
        render :edit, status: unprocessable_entity
      end
    end

    def destroy
      @product.destroy!
      redirect_to admin_products_path, notice: '商品を削除しました。'
    end

    private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:sku, :name, :description, :price, :original_price, :stock_quantity, :image)
    end
  end
end
