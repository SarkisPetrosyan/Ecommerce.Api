class Order < ApplicationRecord
    has_many :order_detail
    belongs_to :customer
end
