# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart_items = cart_items
    @cart_total = cart_total
  end
end
