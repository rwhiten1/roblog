require 'test_helper'
require File.dirname(__FILE__) + '/../helpers/helper_module'

class CommentsControllerTest < ActionController::TestCase
  include TestHelpers
  #set up the roles for all the users
  
  
  #test "should get index" do
  #  get :index
  #  assert_response :success
  #  assert_not_nil assigns(:comments)
  #end
  #
  #test "should get new" do
  #  get :new
  #  assert_response :success
  #end
  
  def setup
    #set up the users and their roles
    set_up_roles
  end
  
  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, {:comment => {:body => comments(:one).body, :article_id => articles(:one).id , :user_id => users(:commenter).id}},
                    {:user=> users(:commenter).id}
    end
  
    assert_redirected_to comment_path(assigns(:comment))
    assigns(:comment).destroy
  end
  
  test "should show comment" do
    get :show, {:id => comments(:one).id},{:user=> users(:commenter).id}
    assert_response :success
  end
  
  test "should get edit" do
    get :edit, {:id => comments(:one).id}, {:user=> users(:commenter).id}
    assert_response :success
  end
  
  test "should update comment" do
    put :update, {:id => comments(:one).id, 
                  :comment => {:body => "updated comment", :article_id => articles(:one).id, :user_id => users(:commenter).id}},
                  {:user=> users(:commenter).id}
    assert_redirected_to comment_path(assigns(:comment))
    comment = assigns(:comment)
    assert(comment.body == "updated comment", "Comment body didn't get updated: #{comment.body}")
  end
  
  test "should destroy comment" do
    #create a comment
    post :create, {:comment => {:body => comments(:one).body, :article_id => articles(:one).id , :user_id => users(:commenter).id}},
                  {:user=> users(:commenter).id}
                  
                  
    assert_difference('Comment.count', -1) do
     
      delete :destroy, {:id => comments(:one).id}, {:user=> users(:commenter).id}
    end
    
    
  
    assert_redirected_to comments_path
  end
end
