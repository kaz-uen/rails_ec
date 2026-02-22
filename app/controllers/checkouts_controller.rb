# frozen_string_literal: true

class CheckoutsController < ApplicationController
  def create
    cart = current_cart
    return redirect_to cart_path, alert: 'カートが空です。' if cart.cart_items.empty?

    @order = Order.new(order_params)
    @order.total_price = cart.total

    ActiveRecord::Base.transaction do
      # 在庫チェック（不足していればロールバック）
      # product_id の昇順でソートしてロックを取得（デッドロック防止）
      cart.cart_items.includes(:product).sort_by(&:product_id).each do |cart_item|
        product = cart_item.product.lock!
        raise ActiveRecord::RecordInvalid, product if product.stock_quantity < cart_item.quantity
      end

      @order.save!
      cart.cart_items.includes(:product).each do |cart_item|
        @order.order_items.create!(
          product_name: cart_item.product.name,
          price_at_purchase: cart_item.product.price,
          quantity: cart_item.quantity
        )
        cart_item.product.decrement!(:stock_quantity, cart_item.quantity)
      end
      cart.destroy!
      session[:cart_id] = nil
    end

    OrderMailer.order_confirmation(@order).deliver_now
    redirect_to root_path, notice: '購入ありがとうございます。'
  rescue ActiveRecord::RecordInvalid
    # エラー時はカート情報を再取得
    @cart_items = cart_items
    @cart_total = cart_total
    flash.now[:alert] = '購入処理に失敗しました。入力内容を確認してください。'
    render 'carts/show', status: :unprocessable_entity
  end

  private

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :username, :email,
      :address, :address2, :country, :state, :zip,
      :card_name, :card_number, :card_exp, :card_cvv
    )
  end
end
