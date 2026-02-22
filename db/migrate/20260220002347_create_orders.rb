# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false
      t.string :email
      t.string :address, null: false
      t.string :address2
      t.string :country, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.integer :total_price, null: false
      t.string :card_name, null: false
      t.string :card_number, null: false
      t.string :card_exp, null: false
      t.string :card_cvv, null: false

      t.timestamps
    end

    add_index :orders, :username
    add_index :orders, :email
  end
end
