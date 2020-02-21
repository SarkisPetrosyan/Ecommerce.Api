class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :email, :customerName, :contactName, :address, :city, :postalCode, :country, :role
end
