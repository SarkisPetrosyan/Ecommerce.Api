class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  swagger_controller :employees, "Employees Management"



  swagger_api :index do
    summary "Fetches all Employee items"
    notes "This lists all the active employee"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
  end

  # GET /employees
  def index
    @employees = Employee.all

    render json: @employees
  end

  swagger_api :show do
    summary "Fetches a single Employee item"
    param :path, :id, :integer, :optional, "Employee Id"
    response :ok, "Success", :Employee
    response :unauthorized
    response :not_acceptable
    response :not_found
  end
  # GET /employees/1
  def show
    render json: @employee
  end


  swagger_api :create do
    summary "Creates a new Employee"
    param :form, :lastName, :string, :required, "Employee lastName"    
    param :form, :firstName, :string, :required, "Employee Name"    
    param :form, :birthDay, :datetime, :required, "Employee Birth Day"    
    param :form, :photo, :string, :required, "Employee Photo"    
    param :form, :notes, :string, :required, "Employee Notes"
    response :unauthorized
    response :not_acceptable
  end
  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end


swagger_api :update do
    summary "Updates an existing Employee"
    param :path, :id, :integer, :required, "Employee Id"
    param :form, :lastName, :string, :required, "Employee lastName"    
    param :form, :firstName, :string, :required, "Employee Name"    
    param :form, :birthDay, :datetime, :required, "Employee Birth Day"    
    param :form, :photo, :string, :required, "Employee Photo"    
    param :form, :notes, :string, :required, "Employee Notes"    
    response :unauthorized
    response :not_found
    response :not_acceptable
  end
  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end


  swagger_api :destroy do
    summary "Deletes an existing Employee item"
    param :path, :id, :integer, :optional, "Employee Id"
    response :unauthorized
    response :not_found
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_params
      params.require(:employee).permit(:lastName, :firstName, :birthDay, :photo, :notes)
    end
end
