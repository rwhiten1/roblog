Given /^an unpublished article titled "([^\"]*)"$/ do |title|
  Factory.create(:article, :title => title)
end

When /^I create a new article named "([^"]*)" with a body of "([^"]*)"$/ do |title, body|
  
  When %{I follow "Administration"}
  And %{I follow "New Article"}
  fill_in "Title", :with => title
  fill_in "Synopsis", :with => body
  fill_in "Body", :with => body
  check "Publish it?"
  click_button "Save Article"
  
end

When /^I go back to the main page$/ do
  visit "/articles"
end

Given /^I create the following articles:$/ do |table|
  # table is a Cucumber::Ast::Table
  When %{I follow "Administration"}
  table.hashes.each do |hash|
    
    And %{I follow "New Article"}
    fill_in "Title", :with => title
    fill_in "Synopsis", :with => body
    fill_in "Body", :with => body
    check "Publish It?"
    click_button "Save Article"
    
  end
end

Given /^I log out$/ do
  visit('/agents/sign_out') # ensure that at least
end
