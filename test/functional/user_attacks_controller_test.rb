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

  #
  # createFromPhone Tests
  #

  test "should create user_attack from phone" do
    assert_difference('UserAttack.count') do
      post :createFromPhone, :user_attack => { :attacker_fbid => 54321, :victim_fbid => 98765, :victim_name => 'Zahra', :attack_name => 'attackone.jpg' }, :device_token => -1
    end

    # Verify that the id_hash was saved correctly
    assert_not_nil assigns(:user_attack).id_hash

    assert_redirected_to user_attack_path(assigns(:user_attack))
  end


  test "should create new user from attacker user_attack by phone" do
    assert_difference('User.count') do
      post :createFromPhone, :user_attack => { :attacker_fbid => 13579, :victim_fbid => 98765, :victim_name => 'Zahra', :attack_name => 'attackone.jpg' }, :device_token => -1
    end
    assert_not_nil assigns(:attacker)
    assert_not_nil assigns(:victim)

    #Assert properties about the attacker object
    assert_equal(assigns(:attacker).fbid, 13579, "FBID is wrong")
    assert_equal(assigns(:attacker).name, "Unknown", "Name is wrong")
    assert assigns(:attacker).device_token == -1

    assert_redirected_to user_attack_path(assigns(:user_attack))
  end


  test "should record device token for known user that doesn't have a device token" do
    assert_difference('UserAttack.count') do
      post :createFromPhone, :user_attack => { :attacker_fbid => 24680, :victim_fbid => 98765, :victim_name => 'Zahra', :attack_name => 'attackone.jpg' }, :device_token => -1
    end
    assert_not_nil assigns(:attacker)
    assert_not_nil assigns(:victim)

    #Assert properties about the attacker object -- specifically make sure that the device token is set correctly
    assert_equal(assigns(:attacker).fbid, "24680", "FBID is wrong")
    assert assigns(:attacker).device_token == -1

    assert_redirected_to user_attack_path(assigns(:user_attack))
  end


  test "should record new device token for known user with a previous device token" do
    assert_difference('UserAttack.count') do
      post :createFromPhone, :user_attack => { :attacker_fbid => 54321, :victim_fbid => 98765, :victim_name => 'Zahra', :attack_name => 'attackone.jpg' }, :device_token => -2
    end
    assert_not_nil assigns(:attacker)
    assert_not_nil assigns(:victim)

    #Assert properties about the attacker object -- specifically make sure that the device token has updated correctly
    assert_equal(assigns(:attacker).fbid, "54321", "FBID is wrong")
    assert assigns(:attacker).device_token == -2

    assert_redirected_to user_attack_path(assigns(:user_attack))
  end


  test "should create new user from victim from user_attack by phone" do
    assert_difference('User.count') do
      post :createFromPhone, :user_attack => { :attacker_fbid => 54321, :victim_fbid => 13579, :victim_name => 'Zahra', :attack_name => 'attackone.jpg' }, :device_token => -1
    end
    assert_not_nil assigns(:attacker)
    assert_not_nil assigns(:victim)

    #Assert properties about the victim object
    assert_equal(assigns(:victim).fbid, 13579, "FBID is wrong")

    assert_redirected_to user_attack_path(assigns(:user_attack))
  end


  test "should update victim user name when sent by phone" do
    assert_difference('UserAttack.count') do
      post :createFromPhone, :user_attack => { :attacker_fbid => 54321, :victim_fbid => 18219, :victim_name => 'Ryan Gerard', :attack_name => 'attackone.jpg' }, :device_token => -1
    end
    assert_not_nil assigns(:attacker)
    assert_not_nil assigns(:victim)

    #Assert properties about the victim object -- specifically make sure that the name has updated
    assert_equal(assigns(:victim).fbid, "18219", "FBID is wrong")
    assert_equal(assigns(:victim).name, "Ryan Gerard", "Name is wrong")

    assert_redirected_to user_attack_path(assigns(:user_attack))
  end

  #
  #  End createFromPhone tests
  #


  #
  # lookup Teste
  #

  test "lookup recent attacks" do
    get :lookup, :fbid => 54321, :lastid => -1, :device_token => -1

    assert_not_nil assigns(:user)
    assert_not_nil assigns(:attack_array)
    assert_equal(assigns(:attack_array).count, 1, "Array count is not 1")
    assert_equal(assigns(:user).appUser, true, "appUser is wrong")
    assert_response :success

    assert_equal(assigns(:attack_array)[0]['attack_id'], 2, "UserAttack ID is not 2")
    assert_equal(assigns(:attack_array)[0]['message'], 'What what', "Message is not oorrect")
  end


  test "should create new user from lookup" do
    assert_difference('User.count') do
      get :lookup, :fbid => 34216, :lastid => -1, :device_token => -1
    end

    assert_not_nil assigns(:user)

    #Assert properties about the user object
    assert_equal(assigns(:user).fbid, 34216, "FBID is wrong")
    assert_equal(assigns(:user).name, "Unknown", "Name is wrong")
    assert_equal(assigns(:user).device_token, -1, "Device token is wrong")
    assert_equal(assigns(:user).appUser, true, "appUser is wrong")

    assert_response :success
  end


  test "should record device token for known user that doesn't have a device token on lookup" do
    get :lookup, :fbid => 24680, :lastid => -1, :device_token => -1

    assert_not_nil assigns(:user)
    assert_equal(assigns(:user).device_token, -1, "Device token is wrong")

    assert_response :success
  end


  test "should record new device token for known user with a previous device token on lookup" do
    get :lookup, :fbid => 18219, :lastid => -1, :device_token => -2

    assert_not_nil assigns(:user)
    assert_equal(assigns(:user).device_token, -2, "Device token is wrong")

    assert_response :success
  end

  #
  #  End lookup tests
  #

  test "should show user_attack" do
    get :show, :id => @user_attack.to_param
    assert_not_nil assigns(:attacker)
    assert_not_nil assigns(:victim)
    assert_not_nil assigns(:attack)

    assert_response :success
  end

  test "should show user_attack by hash" do
    get :show, :hash => @user_attack.id_hash
    assert_not_nil assigns(:attacker)
    assert_not_nil assigns(:victim)
    assert_not_nil assigns(:attack)

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
