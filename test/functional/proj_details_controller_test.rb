require 'test_helper'

class ProjDetailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proj_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proj_detail" do
    assert_difference('ProjDetail.count') do
      post :create, :proj_detail => { }
    end

    assert_redirected_to proj_detail_path(assigns(:proj_detail))
  end

  test "should show proj_detail" do
    get :show, :id => proj_details(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => proj_details(:one).to_param
    assert_response :success
  end

  test "should update proj_detail" do
    put :update, :id => proj_details(:one).to_param, :proj_detail => { }
    assert_redirected_to proj_detail_path(assigns(:proj_detail))
  end

  test "should destroy proj_detail" do
    assert_difference('ProjDetail.count', -1) do
      delete :destroy, :id => proj_details(:one).to_param
    end

    assert_redirected_to proj_details_path
  end
end
