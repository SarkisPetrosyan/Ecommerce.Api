class Customer < ApplicationRecord
    has_secure_password
    validates :email, presence: true

    def to_token_payload
        {
            sub: id,
            email: email
        }
    end

    has_many :orders, dependent: :destroy

    def can_modify_customer?(customer_id)
        role == 'admin' || id.to_s == customer_id.to_s
      end
    
      def is_admin?
        role == 'admin'
      end
end
