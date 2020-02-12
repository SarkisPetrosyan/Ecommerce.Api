class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :update, :destroy]

  swagger_controller :suppliers, "Supplier Management"

  swagger_api :index do
    summary "Fetches all Suppliers items"
    notes "This lists all the active suppliers"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
  end

  # GET /suppliers
  def index
    @suppliers = Supplier.all

    render json: @suppliers
  end

  swagger_api :show do
    summary "Fetches a single Supplier item"
    param :path, :id, :integer, :required, "Supplier Id"
    response :ok, "Success", :Supplier
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  # GET /suppliers/1
  def show
    #Category.find_by(id: 21).products
    #https://www.sitepoint.com/master-many-to-many-associations-with-activerecord/
    #Product.joins(:categories).where(categories: {categoryName: 'Pappardelle alla Bolognese'}).distinct.map {|x| puts x.productName}
    #testin og new branch
    render json: @supplier
  end

  swagger_api :create do
    summary "Creates a new Supplier"
    param :form, :supplierName, :string, :required, "Supplier Name"
    param :form, :contactName , :string, :required, "Contact Name"
    param :form, :address, :string, :required, "Address"
    param :form, :city, :string, :required, "City"
    param :form, :postalCode, :string, :required, "Postal Code"
    param :form, :country, :string, :required, "Country"
    param_list :form, :phone, :string, :required, "Phone"
    response :unauthorized
    response :not_acceptable
  end
  # POST /suppliers
  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      render json: @supplier, status: :created, location: @supplier
    else
      render json: @supplier.errors, status: :unprocessable_entity
    end
  end

  swagger_api :update do
    summary "Update a existing Supplier"
    param :path, :id, :integer, :required, "Supplier Id"
    param :form, :supplierName, :string, :required, "Supplier Name"
    param :form, :contactName , :string, :required, "Contact Name"
    param :form, :address, :string, :required, "Address"
    param :form, :city, :string, :required, "City"
    param :form, :postalCode, :string, :required, "Postal Code"
    param :form, :country, :string, :required, "Country"
    param_list :form, :phone, :string, :required, "Phone"
    response :unauthorized
    response :not_acceptable
  end
  # PATCH/PUT /suppliers/1
  def update
    if @supplier.update(supplier_params)
      render json: @supplier
    else
      render json: @supplier.errors, status: :unprocessable_entity
    end
  end

  # DELETE /suppliers/1
  def destroy
    @supplier.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def supplier_params
      puts params
      params.require(:supplier).permit(:supplierName, :contactName, :address, :city, :postalCode, :country, :phone)
    end
end
