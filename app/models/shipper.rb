class Shipper < ApplicationRecord
    has_many :orders, dependent: :destroy
end
