class Customer < ApplicationRecord
    has_secure_password
    validates :email, presence: true

    has_many :orders, dependent: :destroy
    has_many :shopping_carts, dependent: :destroy

    def to_token_payload
        {
            sub: id,
            email: email
        }
    end


    def can_modify_customer?(customer_id)
        role == 'admin' || id.to_s == customer_id.to_s
      end
    
      def is_admin?
        role == 'admin'
      end
end
