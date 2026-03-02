# frozen_string_literal: true

class AddPromotionCodeIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :promotion_code, null: true, foreign_key: true
  end
end
