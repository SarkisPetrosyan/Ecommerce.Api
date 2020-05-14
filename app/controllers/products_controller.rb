class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]


  # GET /categories
  def index
    product = Product.all
    render json: product
  end


  # GET /categories/1
  def show
    render json: @product
  end

  def searchProduct  
    if params[:search].blank?  
      render status: :not_found
    else  
      parameter = params[:search].downcase  
      results = Product.all.where("lower(productName) LIKE :search", search: "#{parameter}%")
      render json: results  
    end  
  end

  # POST /categories
  def create
    product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end 



  # PATCH/PUT /categories/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  

  # DELETE /categories/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:id, :productName, :unit, :price)
    end
end
