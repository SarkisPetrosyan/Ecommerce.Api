class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  swagger_controller :products, "Products Management"



  swagger_api :index do
    summary "Fetches all product items"
    notes "This lists all the active product"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
  end

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  swagger_api :show do
    summary "Fetches a single Product item"
    param :path, :id, :integer, :optional, "Product Id"
    response :ok, "Success", :Product
    response :unauthorized
    response :not_acceptable
    response :not_found
  end
  # GET /products/1
  def show
    render json: @products
  end


  swagger_api :create do
    summary "Creates a new Product"       
    param :form, :productName, :string, :required, "Product Name"    
    param :form, :unit, :string, :required, "Product Unit"    
    param :form, :price, :string, :required, "Product Price"    
    param :form, :supplier_id, :integer, :required, "Product supplier_id"   
    response :unauthorized
    response :not_acceptable
  end
  # POST /products
  def create
    @products = Product.new(product_params)

    if @products.save
      render json: @products, status: :created, location: @products
    else
      render json: @products.errors, status: :unprocessable_entity
    end
  end


swagger_api :update do
    summary "Updates an existing Product"
    param :path, :id, :integer, :required, "Product Id"
    param :form, :lastName, :string, :required, "Product lastName"    
    param :form, :firstName, :string, :required, "Product Name"    
    param :form, :birthDay, :datetime, :required, "Product Birth Day"    
    param :form, :photo, :string, :required, "Product Photo"    
    param :form, :notes, :string, :required, "Product Notes"    
    response :unauthorized
    response :not_found
    response :not_acceptable
  end
  # PATCH/PUT /products/1
  def update
    if @products.update(product_params)
      render json: @products
    else
      render json: @products.errors, status: :unprocessable_entity
    end
  end


  swagger_api :destroy do
    summary "Deletes an existing Product item"
    param :path, :id, :integer, :optional, "Product Id"
    response :unauthorized
    response :not_found
  end

  # DELETE /products/1
  def destroy
    @products.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @products = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:productName, :unit, :price, :supplier_id)
    end
end
