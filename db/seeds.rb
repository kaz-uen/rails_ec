# frozen_string_literal: true

require 'open-uri'

# 既存の商品を削除
Product.destroy_all

# サンプル商品データ
products_data = [
  {
    sku: 'BST-001',
    name: '商品1',
    description: 'これは商品1の説明です。高品質でおすすめの商品です。',
    price: 1000,
    original_price: 1200,
    stock_quantity: 50,
    image_url: 'https://placehold.jp/450x300.jpg?text=Product+1'
  },
  {
    sku: 'BST-002',
    name: '商品2',
    description: 'これは商品2の説明です。人気の商品です。',
    price: 2000,
    original_price: nil,
    stock_quantity: 30,
    image_url: 'https://placehold.jp/450x300.jpg?text=Product+2'
  },
  {
    sku: 'BST-003',
    name: '商品3',
    description: 'これは商品3の説明です。新商品です。',
    price: 3000,
    original_price: 3500,
    stock_quantity: 20,
    image_url: 'https://placehold.jp/450x300.jpg?text=Product+3'
  },
  {
    sku: 'BST-004',
    name: '商品4',
    description: 'これは商品4の説明です。お得な商品です。',
    price: 1500,
    original_price: nil,
    stock_quantity: 40,
    image_url: 'https://placehold.jp/450x300.jpg?text=Product+4'
  },
  {
    sku: 'BST-005',
    name: '商品5',
    description: 'これは商品5の説明です。限定商品です。',
    price: 2500,
    original_price: 3000,
    stock_quantity: 15,
    image_url: 'https://placehold.jp/450x300.jpg?text=Product+5'
  },
  {
    sku: 'BST-006',
    name: '商品6',
    description: 'これは商品6の説明です。おすすめ商品です。',
    price: 1800,
    original_price: nil,
    stock_quantity: 25,
    image_url: 'https://placehold.jp/450x300.jpg?text=Product+6'
  },
  {
    sku: 'BST-007',
    name: '商品7',
    description: 'これは商品7の説明です。おすすめ商品です。',
    price: 1800,
    original_price: nil,
    stock_quantity: 25,
    image_url: 'https://placehold.jp/450x300.jpg?text=Product+7'
  },
  {
    sku: 'BST-008',
    name: '商品8',
    description: 'これは商品8の説明です。おすすめ商品です。',
    price: 1800,
    original_price: nil,
    stock_quantity: 25,
    image_url: 'https://placehold.jp/450x300.jpg?text=Product+8'
  }
]

products_data.each do |data|
  product = Product.create!(
    sku: data[:sku],
    name: data[:name],
    description: data[:description],
    price: data[:price],
    original_price: data[:original_price],
    stock_quantity: data[:stock_quantity]
    # is_on_saleは自動設定されるため、指定不要
  )

  # 画像を添付
  image = URI.parse(data[:image_url]).open
  product.image.attach(
    io: image,
    filename: "#{data[:sku].parameterize}.jpg",
    content_type: 'image/jpeg'
  )
  Rails.logger.info "Created product: #{product.name} (SKU: #{product.sku}, On Sale: #{product.is_on_sale})"
end

Rails.logger.info "Seeded #{Product.count} products"
