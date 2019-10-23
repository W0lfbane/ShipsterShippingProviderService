require 'test_helper'

class ShippingProvidersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipping_provider = shipping_providers(:one)
  end

  test "should get index" do
    get shipping_providers_url, as: :json
    assert_response :success
  end

  test "should create shipping_provider" do
    assert_difference('ShippingProvider.count') do
      post shipping_providers_url, params: { shipping_provider: { company: @shipping_provider.company } }, as: :json
    end

    assert_response 201
  end

  test "should show shipping_provider" do
    get shipping_provider_url(@shipping_provider), as: :json
    assert_response :success
  end

  test "should update shipping_provider" do
    patch shipping_provider_url(@shipping_provider), params: { shipping_provider: { company: @shipping_provider.company } }, as: :json
    assert_response 200
  end

  test "should destroy shipping_provider" do
    assert_difference('ShippingProvider.count', -1) do
      delete shipping_provider_url(@shipping_provider), as: :json
    end

    assert_response 204
  end
end
