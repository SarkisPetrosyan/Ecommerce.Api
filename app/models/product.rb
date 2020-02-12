class Product < ApplicationRecord
    has_many :product_category
    has_many :categories, through: :product_category
    belongs_to :supplier
    has_many :order_detail
end
