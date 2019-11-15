require 'test_helper'

class Api::ConvertersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @converter = converters(:one)
  end

  test "should get index" do
    get api_converters_url, as: :json
    assert_response :success
  end

  test "should create converter" do
    assert_difference('Converter.count') do
      post api_converters_url, params: { converter: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show converter" do
    get api_converter_url(@converter), as: :json
    assert_response :success
  end

  test "should update converter" do
    patch api_converter_url(@converter), params: { converter: {  } }, as: :json
    assert_response 200
  end

  test "should destroy converter" do
    assert_difference('Converter.count', -1) do
      delete api_converter_url(@converter), as: :json
    end

    assert_response 204
  end
end
