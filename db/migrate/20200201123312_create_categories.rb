class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :categoryName
      t.string :description

      t.timestamps
    end
  end
end
