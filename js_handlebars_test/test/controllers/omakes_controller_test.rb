require 'test_helper'

class OmakesControllerTest < ActionController::TestCase
  setup do
    @omake = omakes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:omakes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create omake" do
    assert_difference('Omake.count') do
      post :create, omake: { name: @omake.name, price: @omake.price, weight: @omake.weight }
    end

    assert_redirected_to omake_path(assigns(:omake))
  end

  test "should show omake" do
    get :show, id: @omake
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @omake
    assert_response :success
  end

  test "should update omake" do
    patch :update, id: @omake, omake: { name: @omake.name, price: @omake.price, weight: @omake.weight }
    assert_redirected_to omake_path(assigns(:omake))
  end

  test "should destroy omake" do
    assert_difference('Omake.count', -1) do
      delete :destroy, id: @omake
    end

    assert_redirected_to omakes_path
  end
end
