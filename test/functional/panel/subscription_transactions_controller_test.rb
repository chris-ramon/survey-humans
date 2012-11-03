require 'test_helper'

class Panel::SubscriptionTransactionsControllerTest < ActionController::TestCase
  setup do
    @panel_subscription_transaction = panel_subscription_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:panel_subscription_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create panel_subscription_transaction" do
    assert_difference('Panel::SubscriptionTransaction.count') do
      post :create, :panel_subscription_transaction => @panel_subscription_transaction.attributes
    end

    assert_redirected_to panel_subscription_transaction_path(assigns(:panel_subscription_transaction))
  end

  test "should show panel_subscription_transaction" do
    get :show, :id => @panel_subscription_transaction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @panel_subscription_transaction.to_param
    assert_response :success
  end

  test "should update panel_subscription_transaction" do
    put :update, :id => @panel_subscription_transaction.to_param, :panel_subscription_transaction => @panel_subscription_transaction.attributes
    assert_redirected_to panel_subscription_transaction_path(assigns(:panel_subscription_transaction))
  end

  test "should destroy panel_subscription_transaction" do
    assert_difference('Panel::SubscriptionTransaction.count', -1) do
      delete :destroy, :id => @panel_subscription_transaction.to_param
    end

    assert_redirected_to panel_subscription_transactions_path
  end
end
