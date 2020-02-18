class AddColumnToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :email, :string, :null => false, :index => true, :unique => true
    add_column :customers, :password_digest, :string
    add_column :customers, :role, :string, :null => false, :default => 'user'
  end
end
