# frozen_string_literal: true

module Admin
  class OrdersController < BaseController
    layout 'admin'

    def index
      @orders = Order.order(created_at: :desc)
    end

    def show
      @order = Order.find(params[:id])
    end
  end
end
