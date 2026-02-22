# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  describe 'order_confirmation' do
    let(:order) do
      Order.create!(
        first_name: '山田', last_name: '太郎', username: 'yamada',
        address: '東京都', country: '日本', state: '東京都', zip: '1000001',
        total_price: 1000, card_name: 'YAMADA', card_number: '1234', card_exp: '12/25', card_cvv: '123'
      )
    end
    let(:mail) { described_class.order_confirmation(order) }

    it 'sets the correct subject' do
      expect(mail.subject).to eq("ご注文ありがとうございます（注文番号: ##{order.id}）")
    end

    it 'sends to the order email' do
      expect(mail.to).to eq([order.email.presence || 'customer@example.com'])
    end

    it 'sends from the default address' do
      expect(mail.from).to eq([ENV.fetch('MAILER_FROM', 'noreply@example.com')])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(order.id.to_s)
    end
  end
end
