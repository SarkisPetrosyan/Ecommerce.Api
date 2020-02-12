class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.datetime :orderDate

      t.belongs_to :customer
      t.belongs_to :employee
      t.belongs_to :shipper

      t.timestamps
    end
  end
end
