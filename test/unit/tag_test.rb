require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  test "the truth" do
    assert true
  end
  
  test "different articles can have the same tag" do
    a1 = articles(:one)
    a2 = articles(:two)
    t1 = tags(:one)
    a1.add_tag(t1)
    a2.add_tag(t1)
    
    #t1 should have both a1 and a2 in its articles array
    assert_equal(2, t1.articles.count)  
    assert_equal(true, t1.articles.find(a1.id) != nil)
    assert_equal(true, t1.articles.find(a2.id) != nil)
  end
end
