require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: "sports")
  end

  test "should get index action" do
    get :index
    assert_response :success
  end

  test "should get new action" do
    get :new
    assert_response :success
  end

  test "should get show action" do
    get :show, params: { id: @category.id }
    assert_response :success
  end

  test "should get edit action" do
     get :edit, params: { id: @category.id }
    assert_response :success
  end
end
