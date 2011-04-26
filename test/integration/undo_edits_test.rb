require 'test_helper'

class UndoEditsTest < ActionController::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  #test "undo edits after a preview" do
  #  admin = login(:admin)
  #  admin.create_article({:title=>"New Article", :synopsis => "Synopsis", :body => "The article body"})
  #  article = Article.find_by_title("New Article")
  #  admin.edit_article(article.id)
  #  #this should commit changes when the "preview link is clicked"
  #  admin.preview_article(article.id,{:synopsis => "Synopsis Two", :body => "The new body"})
  #  admin.undo_changes(article.id)
  #  article = nil
  #  #now, if we look the article back up, it should have the old body and the old synopsis
  #  article2 = Article.find_by_title("New Article")
  #  assert_equal("The article body", article2.body)
  #  assert_equal("Synopsis", article2.synopsis)
  #  article2.destroy
  #end
  #
  #private
  #
  #module CustomDsl
  #  def login(user)
  #    open_session do |sess|
  #      sess.extend(CustomDsl)
  #      u = users(user)
  #      sess.post "/login", :username=>u.username, :password=>"password"
  #      asert_equal '/adminarticles', path
  #    end
  #  end
  #  
  #  def create_article(params)
  #    post "adminarticles/create", params
  #  end
  #  
  #  def edit_article(id)
  #    get "adminarticles/#{id}/edit"
  #  end
  #  
  #  def preview_article(id,params)
  #    put "adminarticles/#{id}", params
  #  end
  #  
  #  def undo_changes(id)
  #    #really, the same thing as a call GET adminarticles/:id/edit
  #    get "adminarticles/#{id}/edit"
  #  end
  #  
  #end
  
end
