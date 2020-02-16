class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy,]
  before_action :set_category_product, only: [:productCategory, :destroyproductCategory]
  before_action :set_category_prod, only: [:CategoryProd]

  swagger_controller :categories, "Categories Management"

  swagger_api :index do
    summary "Fetches all Categories items"
    notes "This lists all the active categories"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
  end

  # GET /categories
  def index
    @categories = Category.all

    render json: @categories
  end

  swagger_api :show do
    summary "Fetches a single Categories item"
    param :path, :id, :integer, :optional, "Category Id"
    response :ok, "Success", :Category
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  # GET /categories/1
  def show
    render json: @category
  end

  swagger_api :create do
    summary "Creates a new Category"
    param :form, :"category[categoryName]", :string, :required, "Category Name"    
    param :form, :"category[description]", :string, :required, "description"
    response :unauthorized
    response :not_acceptable
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

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
  #   puts "error"
  #   productCategory = ProductCategory.where(category_id:  @category.id).first
  #   # productCategory = ProductCategory.all  
  #   puts "error"
  #   # raise ActiveRecord::RecordNotFound.new("Product Category was not found") if productCategory.nil?

  #  render json: productCategory    
  end
  swagger_api :CategoryPro do
    summary "Fetches all Categories items"
    notes "This lists all the active categories"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
  end
  
  def CategoryPro
    # productCategory = ProductCategory.where(category_id:  @category.id).first;    
    productCategory = ProductCategory.all  
    # raise ActiveRecord::RecordNotFound.new("Product Category was not found") if productCategory.nil?

   render json: productCategory    
  end

  swagger_api :update do
    summary "Update a existing Category"
    param :path, :id, :integer, :required, "Category Id"
    param :form, :"category[categoryName]", :string, :required, "Category Name"
    param :form, :"category[description]", :string, :required, "description"
    response :unauthorized
    response :not_acceptable
  end

  # PATCH/PUT /categories/1
  def update
    if @categyor.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  swagger_api :destroy do
    summary "Deletes an existing Category item"
    param :form, :categoryId, :integer, :optional, "Category Id"
    param :form, :productId, :integer, :optional, "Category Id"
    response :unauthorized
    response :not_found
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def set_category_prod
      data = params.permit(:categoryId)      
      @category = Category.find(data[:categoryId]);
    end

    def set_category_product
      data = params.permit(:categoryId, :productId)      
      @category = Category.find(data[:categoryId]);
      @product = Product.find(data[:productId]);      
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:categoryName, :description)
    end
end
