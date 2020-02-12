class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :productName
      t.string :unit
      t.decimal :price

      t.belongs_to :supplier
      t.timestamps
    end
  end
end