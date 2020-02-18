class ApplicationController < ActionController::API
    include Swagger::Docs::ImpotentMethods
    include Knock::Authenticable
  

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  
    def render_unprocessable_entity_response(exception)
      render json: exception.record.errors, status: :unprocessable_entity
    end
  
    def render_not_found_response(exception)
      render json: { error: exception.message }, status: :not_found
    end

    protected
  
    def authorize_as_admin
      return head(:unauthorized) unless !current_customer.nil? && current_customer.is_admin?
    end

end
