class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :customerName, :address, :city
end
