class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.integer :quantity

      t.belongs_to :order
      t.belongs_to :product

      t.timestamps
    end
  end
end
