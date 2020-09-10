class AddContactNameToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :contact_name, :string
  end
end
