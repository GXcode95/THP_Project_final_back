require "test_helper"

class RentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rent = rents(:one)
  end

  test "should get index" do
    get rents_url, as: :json
    assert_response :success
  end

  test "should create rent" do
    assert_difference('Rent.count') do
      post rents_url, params: { rent: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show rent" do
    get rent_url(@rent), as: :json
    assert_response :success
  end

  test "should update rent" do
    patch rent_url(@rent), params: { rent: {  } }, as: :json
    assert_response 200
  end

  test "should destroy rent" do
    assert_difference('Rent.count', -1) do
      delete rent_url(@rent), as: :json
    end

    assert_response 204
  end
end
