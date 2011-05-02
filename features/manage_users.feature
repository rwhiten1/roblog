@user_management
Feature: Manage Users
	In Order to administer blog users
	As an administrator
	I want to create and manage users
	
	Background:
		Given the following users
			| user      | password | role      |
			| hmfic     | secret   | Superuser |
			| commenter | secret   | Commenter |
			| publisher | secret   | Publisher |
	
	
	Scenario Outline: Users List
		When I am logged in as "<user>" with a password of "secret"
		When I go to the list of users
		Then I should <action> "List of Users"
		
		Examples:
			 | user      | action  |
			 | hmfic     | see     |
			 |           | not see |
			 | commenter | not see |
			 | publisher | not see |
	

	Scenario: Create New User From An Article Page
		Given I have no users
			And I have one article named test article
			And I am on the list of articles
		Then I follow "test article"
		Then I follow "Register"
		When I fill in the following:
		 | Username              | newuser            |
		 | Email                 | newuser@roblog.com |
		 | Password              | password           |
		 | Password confirmation | password           |
		 | Last name             | Doe                |
		 | First name            | John               |
		And I press "Sign up"
		Then I should see "test article"
		And I should not see "Register"
		And I should not see "Login"
		And I should have 1 user
		
	
	Scenario: Assign a role to a user
		When I am logged in as "hmfic" with a password of "secret"
		And I follow "Administration"
		And I follow "Manage Users"
		And I follow "commenter"
		Then the "user[roles][Commenter]" checkbox should be checked
		When I check "user[roles][Publisher]"
		And I press "Update User"
		Then I should see "hmfic"
			And I should see "commenter"
			And I should see "publisher"
	
	
	@new_user_default
	Scenario: A new user is assigned a commenter role by default
	  Given I am on the home page
			And I have one article named test article
	  When I follow "Sign up"
	  	And I fill in the following:
				 | Username              | new_user         |
				 | Email                 | newuser@blog.com |
				 | Password              | password         |
				 | Password confirmation | password         |
				 | Last name             | Doe              |
				 | First name            | John             |	
			And I press "Sign up"
			And I am on the list of articles
			And I follow "test article"
		Then I should see the comment form
		When I fill in "comment_body" with "This is a new comment"
			And I press "Create Comment"
		Then I should be on the "test article" page
			And I should see "This is a new comment"
	
	
	
