class Employee < ApplicationRecord
    has_many :orders, dependent: :destroy
end
