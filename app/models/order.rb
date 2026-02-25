# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  validates :first_name, :last_name, :username, :address, :country, :state, :zip,
            :total_price, :card_name, :card_number, :card_exp, :card_cvv,
            presence: true
end
