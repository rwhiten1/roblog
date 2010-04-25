require 'test_helper'

class AdminConsoleControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "should return 302 code without logging in" do
    get :index
    assert_redirected_to :action => "login"
  end
  
  test "should return an article list after logging in" do
    #post :login, :post => {:username => "robrob", :password=>"passw0rd"}
    get :index, {}, {:user => users(:admin).id}
    assert_response :success
    assert_template "index"
    
  end
  
  test "logging in" do
    admin = users(:admin)
    post :login, {:username => admin.username, :password=>"password"}
    assert_redirected_to :action => "index"
    assert_equal(admin.id, session[:user])
  end
  
  test "should return a form for creating an article" do
    get :new, {}, {:user => users(:admin).id}
    assert_response :success
    assert_select 'form' do
      assert_select 'input', 4
      assert_select 'textarea', 2
    end
  end
  
  test "should create a new unpublished post" do
    admin = users(:admin)
    post :login, {:username => admin.username, :password=>"password"}
    assert_difference "Article.count" do
      post :create, :article => {:title => "Test Post", 
                     :synopsis => "synopsis", 
                     :body => "body of the article"}
      
    end
    
    assert_redirected_to :action => "index"
    article = Article.find_by_title("Test Post")
    assert_equal(false, article.published?)
    article.destroy
  end
  
  test "preview an unpublished post" do
    #get the form for a new article
    get :show, {:id => articles(:one).id}, {:user => users(:admin).id}
    assert_response :success
    assert_template "show"
    
  end
  
  test "edit an existing post" do
    get :edit, {:id => articles(:one).id}, {:user => users(:admin)}
    assert_response :success
    assert_template "edit"
    assert(article = assigns(:article), "Cannot find @article")
    
  end
  
  #This test should also cover previewing a new article
  test "preview edits to an article" do
    #login first
    admin = users(:admin)
    post :login, {:username => admin.username, :password=>"password"}
    #create a new article
    post :create, :article => {:title => "Test Post", 
                   :synopsis => "synopsis", 
                   :body => "body of the article"}
    #preview the article with updates
    article = Article.find_by_title("Test Post")
    put :update, { :id=>article.id, :article => {:title => "Test Post",
                              :synopsis => "synopsis",
                              :body => "body of the article with an update"}}
    
    assert_redirected_to :action => "show"
    assert("body of the article with an update" == assigns(:article).body)
    article.destroy              
    
  end
  
  
end
