class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :customerName
      t.string :contactName
      t.string :address
      t.string :city
      t.string :postalCode
      t.string :country

      t.timestamps
    end
  end
end
