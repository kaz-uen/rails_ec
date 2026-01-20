class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.text :description
      t.integer :price
      t.integer :original_price
      t.integer :stock_quantity
      t.boolean :is_on_sale

      t.timestamps
    end
  end
end
