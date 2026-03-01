# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  has_many :orders, dependent: :nullify

  validates :code, presence: true, uniqueness: true, length: { is: 7 }
  validates :discount_amount, presence: true, numericality: { in: 100..1000 }
  validates :is_used, inclusion: { in: [true, false] }

  scope :available, -> { where(is_used: false) }

  # 使用可能かどうかをチェックするカスタムバリデーション
  validate :must_be_available, on: :use

  def use!
    with_lock do
      raise ActiveRecord::RecordInvalid, self unless available?

      update!(is_used: true)
    end
  end

  def available?
    !is_used
  end

  private

  def must_be_available
    errors.add(:base, 'このプロモーションコードは既に使用済みです') if is_used?
  end
end
