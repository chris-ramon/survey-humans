require 'test_helper'

class Panel::OrganizationInvitationsControllerTest < ActionController::TestCase
  setup do
    @panel_organization_invitation = panel_organization_invitations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:panel_organization_invitations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create panel_organization_invitation" do
    assert_difference('Panel::OrganizationInvitation.count') do
      post :create, :panel_organization_invitation => @panel_organization_invitation.attributes
    end

    assert_redirected_to panel_organization_invitation_path(assigns(:panel_organization_invitation))
  end

  test "should show panel_organization_invitation" do
    get :show, :id => @panel_organization_invitation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @panel_organization_invitation.to_param
    assert_response :success
  end

  test "should update panel_organization_invitation" do
    put :update, :id => @panel_organization_invitation.to_param, :panel_organization_invitation => @panel_organization_invitation.attributes
    assert_redirected_to panel_organization_invitation_path(assigns(:panel_organization_invitation))
  end

  test "should destroy panel_organization_invitation" do
    assert_difference('Panel::OrganizationInvitation.count', -1) do
      delete :destroy, :id => @panel_organization_invitation.to_param
    end

    assert_redirected_to panel_organization_invitations_path
  end
end
