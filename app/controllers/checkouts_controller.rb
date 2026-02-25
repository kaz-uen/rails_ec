# frozen_string_literal: true

class CheckoutsController < ApplicationController
  def create
    cart = current_cart
    return redirect_to cart_path, alert: 'カートが空です。' if cart.cart_items.empty?

    @order = Order.new(order_params)
    @order.total_price = cart.total

    ActiveRecord::Base.transaction do
      validate_stock!(cart)
      save_order_and_items!(cart)
      clear_cart!(cart)
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

  def validate_stock!(cart)
    # 在庫チェック（不足していればロールバック）
    # product_id の昇順でソートしてロックを取得（デッドロック防止）
    cart.cart_items.includes(:product).sort_by(&:product_id).each(&:validate_stock!)
  end

  def save_order_and_items!(cart)
    @order.save!
    cart.cart_items.includes(:product).each { |cart_item| cart_item.add_to_order!(@order) }
  end

  def clear_cart!(cart)
    cart.destroy!
    session[:cart_id] = nil
  end

  def order_params
    params.require(:order).permit(
      :first_name, :last_name, :username, :email,
      :address, :address2, :country, :state, :zip,
      :card_name, :card_number, :card_exp, :card_cvv
    )
  end
end
