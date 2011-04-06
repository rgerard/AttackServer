require 'test_helper'

class UserAttacksControllerTest < ActionController::TestCase
  setup do
    @user_attack = user_attacks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_attacks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_attack" do
    assert_difference('UserAttack.count') do
      post :create, :user_attack => @user_attack.attributes
    end

    assert_redirected_to user_attack_path(assigns(:user_attack))
  end

  test "should show user_attack" do
    get :show, :id => @user_attack.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user_attack.to_param
    assert_response :success
  end

  test "should update user_attack" do
    put :update, :id => @user_attack.to_param, :user_attack => @user_attack.attributes
    assert_redirected_to user_attack_path(assigns(:user_attack))
  end

  test "should destroy user_attack" do
    assert_difference('UserAttack.count', -1) do
      delete :destroy, :id => @user_attack.to_param
    end

    assert_redirected_to user_attacks_path
  end
end
