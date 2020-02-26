class CustomersController < ApplicationController
  before_action :authenticate_customer,  only: [:show]  
  before_action :authorize, only: [:update]
  before_action :authorize_as_admin, only: [:index, :destroy]
  before_action :set_customer, only: [:show, :update, :destroy]
  before_action :find_customerId, only: [:getAllOrderDatilsCust]


  swagger_controller :customers, "Customers Management"

  swagger_api :index do
    summary "Fetches all Customer items"
    notes "This lists all the active customer"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
  end

  # GET /customers
  def index
    @customers = Customer.all
    render json: @customers
  end

  swagger_api :show do
    summary "Fetches a single Customer item"
    param :path, :id, :integer, :required, "Customer Id"
    response :ok, "Success", :Customer
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  # GET /customers/1
  def show
    render json: @customer
  end


  swagger_api :create do
    summary "Creates a new Customer"
    param :form, :supplierName, :string, :required, "Customer Name"
    param :form, :contactName , :string, :required, "Contact Name"
    param :form, :address, :string, :required, "Address"
    param :form, :city, :string, :required, "City"
    param :form, :postalCode, :string, :required, "Postal Code"
    param :form, :country, :string, :required, "Country"
    response :unauthorized
    response :not_acceptable
  end
  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end


  swagger_api :update do
    summary "Update a existing Customer"
    param :path, :id, :integer, :required, "Customer Id"
    param :form, :supplierName, :string, :required, "Customer Name"
    param :form, :contactName , :string, :required, "Contact Name"
    param :form, :address, :string, :required, "Address"
    param :form, :city, :string, :required, "City"
    param :form, :postalCode, :string, :required, "Postal Code"
    param :form, :country, :string, :required, "Country"
    response :unauthorized
    response :not_acceptable
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end


  swagger_api :destroy do
    summary "Deletes an existing Customer item"
    param :path, :id, :integer, :optional, "Customer Id"
    response :unauthorized
    response :not_found
  end

  # ________________________________________________________________

  swagger_api :getAllOrderDatilsCust do
    summary "Fetches all products from Order Detils "
    param :form, :customerId, :string, :required, "Customer Id"
    response :ok, "Success", :getAllOrderDatilsCust
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  def getAllOrderDatilsCust
    # ordcust = 
    #customers = OrderDetail.joins(:order => :customer ).select('quantity','customerName','orderDate').where(customer_id: @customer.id) 
    orders = Order.joins(:customer).joins(:order_detail => [:product]).where(customer_id: @customer.id) 
       render json: orders
  end
  
  # (((OrderDetail.joins(:product)).joins
  # 'quantity','productName', 

  # DELETE /customers/1
  def destroy
    @customer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def find_customerId
      data = params.permit(:customerId)      
      @customer = Customer.find(data[:customerId]);
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.require(:customer).permit(:email, :password, :password_confirmation, :customerName, :contactName, :address, :city, :postalCode, :country)
    end

    def authorize
      return head(:unauthorized) unless current_customer && current_customer.can_modify_customer?(params[:id])
    end
end
