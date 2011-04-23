@article_management
Feature: Manage Articles
	In Order to administer articles
	As a Publisher
	I Want to create and manage articles
	
	Background:
		Given the following users
			| user      | password | role      |
			| hmfic     | secret   | Superuser |
			| commenter | secret   | Commenter |
			| publisher | secret   | Publisher |
			| other_user| secret   | Publisher |

	
	Scenario: Edit Article from Admin Page
		Given an unpublished article titled "Test Article"
		When I am logged in as "hmfic" with a password of "secret"
			And I follow "Administration"
			And I follow "edit"
		Then I should see "Test Article"
			And I should see "Synopsis"
			And I should see "Body"

	
	Scenario: Show Unpublished Article
		Given an unpublished article titled "Second Test Article"
	 	When I am logged in as "hmfic" with a password of "secret"
		 	And I follow "Administration"
		 	And I follow "Second Test Article"
		Then I should see "Second Test Article"
			And I should see "This is a test article"
			And I should see "This is the body of the article"
			
	Scenario: When a user creates a new article they become that article's publisher
	  Given I am logged in as "publisher" with a password of "secret"
	  When I create a new article named "Brand New" with a body of "ipsum lorem"
	  	And I go back to the main page
			And show me the page
	  Then I should see "by: publisher"
	
	
	Scenario: A user should only see their articles
	  Given I am logged in as "publisher" with a password of "secret"
			And I create the following articles:
				|title|body|
				|Article 1|blah blah blah|
				|Article 2 |yada yada yada|
			And I log out
			And I am logged in as "other_user" with a password of "secret"
			And I create the following articles:
				|title|body|
				|Article 3|stuf stuff stuff|
				|Article 4|hippity hoppity|
	  When I go back to the main page
	  Then I should see "Article 3"
			And I should see "Article 4"
			And I should not see "Article 1"
			And I should not see "Article 2"
	
	
	
	
	
	
	
	
	#Scenario: Upload an image to use in articles
	#	Given I am logged in as "hmfic" with a password of "secret"
	#		And I follow "Administration"
	#	Then I should see "Upload Image"
	#	When I fill in "file_field" with "/Users/robwhitener/Documents/pictures/meontheboard.JPG"
	#		And I press "Upload"
	#	Then I should see "Image successfully uploaded"
			
			
	