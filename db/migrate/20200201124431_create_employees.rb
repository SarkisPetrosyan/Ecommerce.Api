class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :lastName
      t.string :firstName
      t.datetime :birthDay
      t.string :photo
      t.text :notes

      t.timestamps
    end
  end
end
