class CreateShoppingCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_carts do |t|
      t.references :product, index: true
      t.references :customer, index: true
      t.integer :total
      t.integer :quantity

      t.timestamps
    end
  end
end
