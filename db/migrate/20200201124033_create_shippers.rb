class CreateShippers < ActiveRecord::Migration[6.0]
  def change
    create_table :shippers do |t|
      t.string :shipperName
      t.string :phone

      t.timestamps
    end
  end
end
