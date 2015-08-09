require 'test_helper'

class ToiletsControllerTest < ActionController::TestCase
  setup do
    @toilet = toilets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:toilets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create toilet" do
    assert_difference('Toilet.count') do
      post :create, toilet: { address: @toilet.address, ave_rate: @toilet.ave_rate, comment: @toilet.comment, japanese: @toilet.japanese, lat: @toilet.lat, long: @toilet.long, multi: @toilet.multi, name: @toilet.name, urinals: @toilet.urinals, user_id: @toilet.user_id, western: @toilet.western }
    end

    assert_redirected_to toilet_path(assigns(:toilet))
  end

  test "should show toilet" do
    get :show, id: @toilet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @toilet
    assert_response :success
  end

  test "should update toilet" do
    patch :update, id: @toilet, toilet: { address: @toilet.address, ave_rate: @toilet.ave_rate, comment: @toilet.comment, japanese: @toilet.japanese, lat: @toilet.lat, long: @toilet.long, multi: @toilet.multi, name: @toilet.name, urinals: @toilet.urinals, user_id: @toilet.user_id, western: @toilet.western }
    assert_redirected_to toilet_path(assigns(:toilet))
  end

  test "should destroy toilet" do
    assert_difference('Toilet.count', -1) do
      delete :destroy, id: @toilet
    end

    assert_redirected_to toilets_path
  end
end
