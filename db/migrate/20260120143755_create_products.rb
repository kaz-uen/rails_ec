class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :sku, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.integer :original_price
      t.integer :stock_quantity, null: false
      t.boolean :is_on_sale, null: false, default: false

      t.timestamps
    end

    add_index :products, :sku, unique: true
  end
end
