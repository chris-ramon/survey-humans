require 'test_helper'

class Panel::GatewaysControllerTest < ActionController::TestCase
  setup do
    @panel_gateway = panel_gateways(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:panel_gateways)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create panel_gateway" do
    assert_difference('Panel::Gateway.count') do
      post :create, :panel_gateway => @panel_gateway.attributes
    end

    assert_redirected_to panel_gateway_path(assigns(:panel_gateway))
  end

  test "should show panel_gateway" do
    get :show, :id => @panel_gateway.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @panel_gateway.to_param
    assert_response :success
  end

  test "should update panel_gateway" do
    put :update, :id => @panel_gateway.to_param, :panel_gateway => @panel_gateway.attributes
    assert_redirected_to panel_gateway_path(assigns(:panel_gateway))
  end

  test "should destroy panel_gateway" do
    assert_difference('Panel::Gateway.count', -1) do
      delete :destroy, :id => @panel_gateway.to_param
    end

    assert_redirected_to panel_gateways_path
  end
end
