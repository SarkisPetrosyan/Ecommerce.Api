class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy,]

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

  

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

   

    

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:categoryName, :description)
    end
end
