class ShippersController < ApplicationController
  before_action :set_shipper, only: [:show, :update, :destroy]

  swagger_controller :suppliers, "Shippers Management"

  swagger_api :index do
    summary "Fetches all Shippers items"
    notes "This lists all the active shippers"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
  end
  # GET /shippers
  def index
    @shippers = Shipper.all

    render json: @shippers
  end

  swagger_api :show do
    summary "Fetches a single Shipper item"
    param :path, :id, :integer, :optional, "Shipper Id"
    response :ok, "Success", :Shipper
    response :unauthorized
    response :not_acceptable
    response :not_found
  end
  # GET /shippers/1
  def show
    render json: @shipper
  end


swagger_api :create do
    summary "Creates a new Shipper"
    param :form, :shipperName, :string, :required, "Shipper Name"    
    param_list :form, :phone, :string, :required, "Phone"
    response :unauthorized
    response :not_acceptable
  end
  # POST /shippers
  def create
    @shipper = Shipper.new(shipper_params)
    
    if @shipper.save
      render json: @shipper, status: :created, location: @shipper
    else
      render json: @shipper.errors, status: :unprocessable_entity
    end
  end
  
  swagger_api :update do
    summary "Updates an existing Shipper"
    param :path, :id, :integer, :required, "Shipper Id"
    param :form, :shipperName, :string, :required, "Shipper Name"
    param :form, :phone, :string, :required, "Phone"    
    response :unauthorized
    response :not_found
    response :not_acceptable
  end

  # PATCH/PUT /shippers/1
  def update
    if @shipper.update(shipper_params)
      render json: @shipper
    else
      render json: @shipper.errors, status: :unprocessable_entity
    end
  end


  swagger_api :destroy do
    summary "Deletes an existing Shipper item"
    param :path, :id, :integer, :optional, "Shipper Id"
    response :unauthorized
    response :not_found
  end
  # DELETE /shippers/1
  def destroy
    @shipper.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper
      @shipper = Shipper.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def shipper_params
      params.require(:shipper).permit(:shipperName, :phone)
    end
end
