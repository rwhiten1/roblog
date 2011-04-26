require 'test_helper'

class AuthenticationFlowsTest < ActionController::IntegrationTest
  fixtures :all
  
  test "login as commenter and return to article" do
    a_sess = open_session do |sess|
      get "/"
      assert_response :success
      #we should be on the articles index page now.
    end
    
    article = articles(:one)
    #get an article
    a_sess.get "articles/#{article.id}"
    
    #at this point we should try to login
    a_sess.get "/login_form",{:id => article.id} #pass the article id
    
    assert_response :success, @response.body
    
    #now, login
    a_sess.post_via_redirect "/login", {:username => "commenter", :password => "password", :article_id => article.id}
    assert_response :success
    assert_equal("articles/#{article.id}", a_sess.path)
    
    #also, need to make sure the right layout was rendered.  My header made of blocks needs to be present
    assert_select "div#header" do
      assert_select "div#block_0_0", true, "The header isn't present.  Wrong layout."
    end
  end
  
  
  
  test "post a comment without logging in" do
    #first, we need to start up a session.
    
    a_session = open_session do |sess|
       #this should put us on the main Articles page
      get "/"
      assert_response :success
      assert_nil(session[:intended_controller])
    end
    
    #now, we need to pick out an article to post a comment on
    article = articles(:one)
    a_session.get "articles/#{article.id}"
    assert_response :success
    assert_nil(session[:intended_controller]) 
    assert_equal("articles/#{article.id}", a_session.path) 
    
    
    #now, attempt to post a comment without having logged in.  This should redirect us to the login screen
    a_session.post_via_redirect "articles/#{article.id}/comments",{:comment => {:body => "A new comment", :article_id => "#{article.id}"}}
    #there should be a redirect and it should put us onto the login form
    #whats in the session:
    session.each do |k,v|
      puts "session[:#{k.to_s}] => #{v}"
    end
    
    assert_nil(flash[:notice])
    assert_equal "/login_form", a_session.path

    #assert_equal("comments", session[:intended_controller], "Intended controller wrong/not present")
    #assert_equal("create", session[:intended_action], "Intended action wrong/not present")
    #assert_equal("articles/#{article.id}", session[:intended_url], "intended url is wrong/not present")
    #now, login as a commenter
    a_session.post_via_redirect "/login", {:username => "commenter", :password => "password"}
    #I want the recdirect take the user back to the article they commented on.
    assert_redirected_to "articles/#{article.id}", "We didn't get redirected.  path: #{a_session.path}"
    #and it would be super nice if the comment they tried to post is still in the text area.
    assert_select "form input#comment_body" do
      assert_select "[value=?]", /A new comment/
    end
    
    #also, need to make sure the right layout was rendered.  My header made of blocks needs to be present
    assert_select "div#header" do
      assert_select "div#block_0_0", true, "The header isn't present.  Wrong layout."
    end
  end
end
