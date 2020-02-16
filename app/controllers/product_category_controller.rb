class ProductCategoryController < ApplicationController
  before_action :set_category_product, only: [:productCategory, :destroyproductCategory]
  before_action :set_category_prod, only: [:CategoryProd]

  swagger_controller :product_category, "Product_categories Management"

  swagger_api :productCategory do
    summary "Creates a new Product Category"
    param :form, :categoryId, :string, :required, "Category Id"    
    param :form, :productId, :string, :required, "Product Id"
    response :unauthorized
    response :not_acceptable
  end

  def productCategory
    ProductCategory.create(product: @product, category: @category);
  end

  swagger_api :destroyproductCategory do
    summary "Deletes an existing Destroy Product Category"
    param :form, :productId, :string, :required, "Product Id"
    param :form, :categoryId, :string, :required, "Category Id"    
    response :unauthorized
    response :not_found
  end

  def destroyproductCategory
    puts "error"
    productCategory = ProductCategory.where(product_id: @product.id, category_id:  @category.id) 
    puts "error" 
    raise ActiveRecord::RecordNotFound.new("Product Category was not found") if productCategory.nil?
    render json: productCategory
  end

  swagger_api :CategoryProd do
    summary "Fetches a single CategoryProd "
    param :form, :categoryId, :string, :required, "Category Id"
    response :ok, "Success", :CategoryProd
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  def CategoryProd
    productCategory = ProductCategory.joins(:product).select('productName').where(category_id:  @category.id) 
    puts "error" 
    
    render json: productCategory
  
  end

  swagger_api :CategoryPro do
    summary "Fetches all CategoryPro items"
    notes "This lists all the active ProductCategory"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
  end
  
  def CategoryPro
    # productCategory = ProductCategory.where(category_id:  @category.id).first;    
    productCategory = ProductCategory.all  
    # raise ActiveRecord::RecordNotFound.new("Product Category was not found") if productCategory.nil?

   render json: productCategory    
  end


  private

  def set_category_product
    data = params.permit(:categoryId, :productId)      
    @category = Category.find(data[:categoryId]);
    @product = Product.find(data[:productId]);      
  end

  def set_category_prod
    data = params.permit(:categoryId)      
    @category = Category.find(data[:categoryId]);
  end



end
