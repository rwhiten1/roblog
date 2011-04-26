require 'test_helper'
require File.expand_path(File.dirname(__FILE__) + "/../../features/support/auth_steps")

class RoleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "get unassigned rights" do
    publ = Role.find_by_name("Publisher")
    comm = Role.find_by_name("Commenter")
    sup = Role.find_by_name("Superuser")
    unused = publ.get_unassigned_rights
    
    expected = comm.rights + sup.rights
    assert_equal(0, unused <=> expected)
    
  end
end
