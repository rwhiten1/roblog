require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User , "Associations" do
  it {should have_many(:articles).through(:author)}
end

describe User, "Authorization" do
  it "Checks roles" do
    a_role = Factory.create(:role, :name => "Superuser")
    c_role = Factory.create(:role, :name => "Commenter" )
    p_role = Factory.create(:role, :name => "Publisher" )
    u = Factory.create(:user)
    u.roles << a_role << c_role << p_role
    u.role?(:superuser).should == true 
  end
end