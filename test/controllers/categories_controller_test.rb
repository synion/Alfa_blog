require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(name: "Szymon", email: "examle@o2.pl", password: "password", admin: true)
  end

  test "should get index action" do
    get :index
    assert_response :success
  end

  test "should get new action" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  test "should get show action" do
    get :show, params: { id: @category.id }
    assert_response :success
  end

  test "should get edit action" do
    session[:user_id] = @user.id
     get :edit, params: { id: @category.id }
    assert_response :success
  end

  test "should not create Categories if admin not login" do
    assert_no_difference "Category.count" do
      post :create, params: { name: "Work" }
    end
    assert_redirected_to categories_path
  end
end
