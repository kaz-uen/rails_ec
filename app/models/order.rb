# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :promotion_code, optional: true
  has_many :order_items, dependent: :destroy

  validates :first_name, :last_name, :username, :address, :country, :state, :zip,
            :total_price, :card_name, :card_number, :card_exp, :card_cvv,
            presence: true
  validate :promotion_code_must_be_available, if: :promotion_code_id?

  # 割引額を取得（プロモーションコードがない場合は0）
  def discount_amount
    promotion_code&.discount_amount || 0
  end

  private

  def promotion_code_must_be_available
    return unless promotion_code

    unless promotion_code.available?
      errors.add(:promotion_code, 'は既に使用済みです')
    end
  end
end
