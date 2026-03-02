# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart_items = cart_items
    @cart_total = cart_total
    @promotion_code = PromotionCode.find_by(code: session[:promotion_code]) if session[:promotion_code]
  end

  def update
    if params[:promotion_code].present?
      # プロモーションコードを適用
      code = params[:promotion_code]
      promotion_code = PromotionCode.available.find_by(code:)

      if promotion_code
        session[:promotion_code] = code
        redirect_to cart_path, notice: 'プロモーションコードを適用しました。'
      else
        redirect_to cart_path, alert: '無効なプロモーションコードです。'
      end
    elsif params[:remove_promotion_code].present?
      # プロモーションコードを解除
      session[:promotion_code] = nil
      redirect_to cart_path, notice: 'プロモーションコードを解除しました。'
    else
      redirect_to cart_path
    end
  end
end
