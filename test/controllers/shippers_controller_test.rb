require 'test_helper'

class ShippersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipper = shippers(:one)
  end

  test "should get index" do
    get shippers_url, as: :json
    assert_response :success
  end

  test "should create shipper" do
    assert_difference('Shipper.count') do
      post shippers_url, params: { shipper: { phone: @shipper.phone, shipperName: @shipper.shipperName } }, as: :json
    end

    assert_response 201
  end

  test "should show shipper" do
    get shipper_url(@shipper), as: :json
    assert_response :success
  end

  test "should update shipper" do
    patch shipper_url(@shipper), params: { shipper: { phone: @shipper.phone, shipperName: @shipper.shipperName } }, as: :json
    assert_response 200
  end

  test "should destroy shipper" do
    assert_difference('Shipper.count', -1) do
      delete shipper_url(@shipper), as: :json
    end

    assert_response 204
  end
end
