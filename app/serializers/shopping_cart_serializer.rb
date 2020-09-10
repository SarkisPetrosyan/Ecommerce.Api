class ShoppingCartSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :customer_id
end
