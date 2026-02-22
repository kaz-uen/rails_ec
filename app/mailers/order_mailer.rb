# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    mail(
      to: @order.email.presence || 'customer@example.com',
      subject: "ご注文ありがとうございます（注文番号: ##{@order.id}）"
    )
  end
end
