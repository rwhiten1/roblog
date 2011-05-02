Given /^an unpublished article titled "([^\"]*)" by "([^"]*)"$/ do |title,author|
  a = Factory.create(:article, :title => title)
  user = User.find_by_username(author)
  user.build_author
  user.author.pseudo_last = "Doe"
  user.author.pseudo_first = "John"
  user.author.articles << a
  user.save
  a.save
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
    fill_in "Title", :with => hash[:title]
    fill_in "Synopsis", :with => hash[:body]
    fill_in "Body", :with => hash[:title]
    check "Publish it?"
    click_button "Save Article"
    
  end
end

Given /^I log out$/ do
  visit('/users/sign_out') # ensure that at least
end

Then /^I should see the comment form$/ do
  page.should have_selector('#new_comment')
end

