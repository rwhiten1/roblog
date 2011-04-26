Given /^I have users named (.+)$/ do |user|
  #the users should already be defined, but I will go ahead and split them out
  user.split(", ").each do |u|
    if !User.find_by_username(u) then
      u_obj = User.new(:username => u, :email => "#{u}@roblog.com")
      u_obj.password = "password"
      u_obj.save
    end
  end
  
end

Given /^I have one article named (.+)$/ do |name|
  a = Article.new(:title => name, :synopsis => "test", :body => "some stuff here")
  a.publish_it
  a.save
end


Then /^I click test "([^\"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end


Given /^I have no users$/ do
  User.delete_all
end


Then /^I should have ([0-9]+) users?$/ do |count|
  User.count.should == count.to_i
end

#Given /^a set of (roles)/ do |roles|
#  if !Role.find_by_name("Publisher") then
#    Factory.create(:publish)
#    Factory.create(:commment)
#    Factory.create(:admin)
#  end
#end
#


Given /^the following rights$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:right, hash)
  end
end

Given /^the following roles$/ do |table|
  table.hashes.each do |hash|
    role = Role.find_by_name(hash[:name])
    if !role then
      right = Right.find_by_name(hash[:right])
      rights = [right]
      role = Factory.create(:role_with_rights,:name => hash[:name], :rights => rights)
    else
      right = Right.find_by_name(hash[:right])
      role.rights << right
    end
    
  end
end


Given /^the following users$/ do |table|
  table.hashes.each do |hash|
    user = Factory.create(:user, :username => hash[:user], :password => "secret", :email => "#{hash[:user]}@some.com")
    #user.password = hash[:password]
    case hash[:role]
      when "Superuser"
        user.roles << Role.find_by_name("Superuser")
        user.roles << Role.find_by_name("Publisher")
        user.roles << Role.find_by_name("Commenter")
      when "Commenter"
        user.roles << Role.find_by_name("Commenter")
      when "Publisher"
        user.roles << Role.find_by_name("Publisher")
        user.roles << Role.find_by_name("Commenter")
        
    end
    user.save
  end
end
#
When /^I am logged in as "([^\"]*)" with a password of "([^\"]*)"$/ do |username, password|
  unless username == ""
    visit "/users/sign_in"
    fill_in "Email", :with => "#{username}@some.com"
    fill_in "Password", :with => password 
    click_button "Sign in"
  end
end

Then /^I should see the following users and roles$/ do |expected_table|
  actual_table = [
    ['username','role']
    ]
  users = User.all
  users.each do |u|
    u.roles.each do |r|
      actual_table << [u.username,r.name]
    end
  end
  expected_table.diff!(actual_table)
end

Then /^I should see the following rights$/ do |table|
  # table is a Cucumber::Ast::Table
  actual_table = [
    ['role', 'right']
    ]
  roles = Role.all
  roles.each do |r|
    r.rights.each do |rt|
      actual_table << [r.name,rt.name]
    end
  end
  
end




