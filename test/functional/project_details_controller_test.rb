require 'test_helper'

class ProjectDetailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_detail" do
    assert_difference('ProjectDetail.count') do
      post :create, :project_detail => { }
    end

    assert_redirected_to project_detail_path(assigns(:project_detail))
  end

  test "should show project_detail" do
    get :show, :id => project_details(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => project_details(:one).to_param
    assert_response :success
  end

  test "should update project_detail" do
    put :update, :id => project_details(:one).to_param, :project_detail => { }
    assert_redirected_to project_detail_path(assigns(:project_detail))
  end

  test "should destroy project_detail" do
    assert_difference('ProjectDetail.count', -1) do
      delete :destroy, :id => project_details(:one).to_param
    end

    assert_redirected_to project_details_path
  end
end
