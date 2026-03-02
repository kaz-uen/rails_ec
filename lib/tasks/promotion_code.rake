# frozen_string_literal: true

namespace :promotion_code do
  desc 'Generate 10 promotion codes'
  task generate: :environment do
    codes = []
    # 100円から1000円まで100円単位でシャッフル
    discount_amounts = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000].shuffle

    10.times do
      # 7桁の英数字コードを生成（重複チェック付き）
      code = loop do
        candidate = SecureRandom.alphanumeric(7).upcase
        break candidate unless PromotionCode.exists?(code: candidate)
      end

      # シャッフル済み配列から順番に取り出す（各割引額が1回ずつ使われる）
      discount_amount = discount_amounts.pop

      promotion_code = PromotionCode.create!(
        code:,
        discount_amount:,
        is_used: false
      )
      codes << { code: promotion_code.code, discount_amount: promotion_code.discount_amount }
      puts "Created: #{promotion_code.code} (割引額: ¥#{promotion_code.discount_amount})"
    end

    puts "\n生成されたプロモーションコード:"
    codes.each do |c|
      puts "  - #{c[:code]} (割引額: ¥#{c[:discount_amount]})"
    end
  end
end
