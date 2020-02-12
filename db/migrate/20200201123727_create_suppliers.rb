class CreateSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      t.string :supplierName
      t.string :contactName
      t.string :address
      t.string :city
      t.string :postalCode
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
