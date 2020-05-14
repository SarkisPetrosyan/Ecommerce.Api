class ProductCategoryController < ApplicationController
  before_action :set_category_product, only: [:productCategory, :destroyproductCategory]
  before_action :set_category_prod, only: [:CategoryProd]
  before_action :find_productcategori, only: [:GetProductCategory]

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
    productCategory = ProductCategory.joins(:product).select('product_id', 'productName', 'unit', 'price').where(category_id:  @category.id)
    if (productCategory.length != 0)
    render json: productCategory
    else
      render status: :not_found
    end  
  end


  swagger_api :CategoryProdAll do
    summary "Fetches all Category Prod All items"
    notes "This lists all the active CategoryProdAll"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
  end

  def CategoryProdAll
    productCategoryAll = ProductCategory.joins(:product, :category).select('productName', 'categoryName' )
    puts "error" 
    
    render json: productCategoryAll
  
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

  def GetProductCategory   
   render json: @productcategori    
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

  def find_productcategori
    @productcategori = ProductCategory.find(params[:id])
  end




end
