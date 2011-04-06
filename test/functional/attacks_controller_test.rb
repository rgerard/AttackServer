require 'test_helper'

class AttacksControllerTest < ActionController::TestCase
  setup do
    @attack = attacks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attacks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attack" do
    assert_difference('Attack.count') do
      post :create, :attack => @attack.attributes
    end

    assert_redirected_to attack_path(assigns(:attack))
  end

  test "should show attack" do
    get :show, :id => @attack.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @attack.to_param
    assert_response :success
  end

  test "should update attack" do
    put :update, :id => @attack.to_param, :attack => @attack.attributes
    assert_redirected_to attack_path(assigns(:attack))
  end

  test "should destroy attack" do
    assert_difference('Attack.count', -1) do
      delete :destroy, :id => @attack.to_param
    end

    assert_redirected_to attacks_path
  end
end
