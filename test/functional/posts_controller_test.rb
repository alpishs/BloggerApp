require './test/test_helper'

class PostsControllerTest < ActionController::TestCase
  include Warden::Test::Helpers
  include Devise::Test::ControllerHelpers

  # called before every single test
  setup :initialize_post

  # called after every single test
  def teardown
    @post = nil
  end

  test "should create post" do
    post_params = {:post => {:post_text => "this is post text", :title => "this is post tite"}}
    assert_difference('Post.count') do
      post :create, params: post_params
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, params: {:id => @post.id}
    end

    assert_response :redirect
  end

  test "should update post" do
    post_params = {:title=>"this is post title", :post_text=>"this is post text"}
    put :update, params: {:id=>@post.id, :post=>post_params}
    assert_response :success
  end

  test "should show post" do
    get :show, params: { :id => @post.id }
    assert_response :success
  end

  def current_user
    @current_user
  end

  def initialize_post
    @current_user = users(:one)
    @post = posts(:one)
  end
end