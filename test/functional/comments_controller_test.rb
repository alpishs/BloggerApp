require './test/test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Warden::Test::Helpers
  include Devise::Test::ControllerHelpers

  # called before every single test
  setup :initialize_post

  # called after every single test
  def teardown
    @comment = nil
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, params: {:comment => {:body => "this is first comment on post"}, post_id: @post.id}
    end

    assert_response :redirect
  end

  def current_user
    @current_user
  end

  def initialize_post
    @current_user = users(:one)
    @post = posts(:one)
  end
end