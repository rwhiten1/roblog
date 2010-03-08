require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  fixtures :articles
  # Replace this with your real tests.
  def setup
  @html = <<-TEXTILE
<h1>Give RedCloth a try!</h1>
<p>A <strong>simple</strong> paragraph with<br />
a line break, some <em>emphasis</em> and a <a href="http://redcloth.org">link</a></p>
<ul>
	<li>an item</li>
	<li>and another</li>
</ul>
<ol>
	<li>one</li>
	<li>two</li>
</ol>
TEXTILE
 
  end
  
  def teardown
    
  end
  
  test "create new article" do
    art = Article.new
    art.body = "blah blah blah blah blah"
    art.synopsis = "a synopsis"
    art.title = "A Title"
    art.save
    art = nil
    
    a1 = Article.find_by_title("A Title")
    assert_not_nil(a1)
    assert_equal("a synopsis", a1.synopsis)
  end
  
  
  test "add comment to article" do
   #grab the first article
   a1 = articles(:one)
   c1 = Comment.new
   c1.body = "this is a comment"
   c1.user_id = 1
   
   puts "In Test: article_id = #{a1.id}"
   a1.add_comment(c1)
   assert_equal(1, a1.comments.size)
   assert_equal(a1.id, a1.comments[0].article_id)
   assert_equal("this is a comment", a1.comments[0].body)
  end
  
  test "delete a comment from an article" do
    a1 = articles(:one)
    c1 = Comment.new
    c1.body = "this is another comment"
    c1.user_id = 1
    a1.add_comment(c1)
    
    assert a1.comments.size > 0
    temp = a1.comments.size
    a1.delete_comment(c1.id)
    
    assert((temp - a1.comments.size) == 1, "difference between old and new comment list size should be 1")
  end
  
  test "textile text is converted to html this side of the db" do
    a2 = articles(:two)
    body = a2.render_to_html
    assert_equal(@html, body+"\n")
  end
  
  test "an article can be marked as published" do
    a2 = articles(:two)
    assert_equal(false, a2.published?)
    #publish the article now
    a2.publish_it
    assert_equal(true, a2.published?)
  end
  
  test "add a tag to an article" do
    a1 = articles(:one)
    t1 = tags(:one)
    a1.add_tag(t1)
    
    assert_equal(1, a1.tags.count)
    assert_equal("category1", a1.tags[0].tag_name)
  end
  
  test "remove a tag from an article" do
    a1 = articles(:one)
    t1 = tags(:one)
    t2 = tags(:two)
    t3 = tags(:three)
    
    a1.add_tag(t1)
    a1.add_tag(t2)
    a1.add_tag(t3)
    
    assert_equal(3, a1.tags.size)
    
    #now, remove the second tag
    a1.remove_tag(t2)
    assert_equal(2, a1.tags.size)
    assert_equal(t1, a1.tags[0])
    assert_equal(t3, a1.tags[1])
  end
  
end
