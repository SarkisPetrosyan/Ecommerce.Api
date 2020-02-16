class AddCoulmsToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :email, :string
    add_column :customers, :login, :string
    add_column :customers, :password, :string
  end
end
