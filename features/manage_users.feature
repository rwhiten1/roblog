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
		And I fill in "Username" with "newuser"
		And I fill in "Email" with "newuser@roblog.com"
		And I fill in "Password" with "password"
		And I fill in "Password confirmation" with "password"
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
			And show me the page
			And I should see "commenter"
			And I should see "publisher"
		#And I should see the following users and roles
		#	  | username  | role      |
		#	  | hmfic     | Superuser |
		#	  | hmfic     | Publisher |
		#	  | hmfic     | Commenter |
		#	  | commenter | Commenter |
		#	  | commenter | Publisher |
		#	  | publisher | Publisher |
		#	  | publisher | Commenter |
	
	
	Scenario: Assign a right to a role
		When I am logged in as "hmfic" with a password of "secret"
		And I follow "Administration"
		And I follow "Manage Roles"
		And I follow "Superuser"
		When I check "role[rights][Show Unpubed Article]"
		And I press "Update Role"
			Then I should see "Superuser"
			And I should see the following rights
 				| role      | right                |
 				| Superuser | Admin Console        |
 				| Superuser | Admin Logout         |
 				| Superuser | Show Users           |
 				| Superuser | Users Index          |
 				| Superuser | Show Unpubed Article |
 				
