require 'test_helper'

class Panel::OrganizationsControllerTest < ActionController::TestCase
  setup do
    @panel_organization = panel_organizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:panel_organizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create panel_organization" do
    assert_difference('Panel::Organization.count') do
      post :create, :panel_organization => @panel_organization.attributes
    end

    assert_redirected_to panel_organization_path(assigns(:panel_organization))
  end

  test "should show panel_organization" do
    get :show, :id => @panel_organization.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @panel_organization.to_param
    assert_response :success
  end

  test "should update panel_organization" do
    put :update, :id => @panel_organization.to_param, :panel_organization => @panel_organization.attributes
    assert_redirected_to panel_organization_path(assigns(:panel_organization))
  end

  test "should destroy panel_organization" do
    assert_difference('Panel::Organization.count', -1) do
      delete :destroy, :id => @panel_organization.to_param
    end

    assert_redirected_to panel_organizations_path
  end
end
