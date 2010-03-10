require 'test_helper'

class AdminConsoleControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "should return a form for creating an article" do
    get :new
    assert_response :success
    assert_select 'form' do
      assert_select 'input', 3
      assert_select 'textarea', 1
    end
  end
  
  test "should create a new unpublished post" do
    assert_difference "Article.count" do
      post :create, :post => {:title => "Test Post", 
                                    :synopsis => "synopsis", 
                                    :body => "body of the article"}
      
    end
    
    assert_redirected_to post_path(assigns(:post))
    assert_equal(false, assigns(:article).published?)
  end
  
end
