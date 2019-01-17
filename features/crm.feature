Feature: Log in and out of the site
  In order to maintain an account
  As a site visitor
  I need to log in and out of the site.

  @javascript
  Scenario: Logs in to the site
    Given I am on "/index.php"
    When I fill in "user_name" with "admin"
    And I fill in "user_password" with "R3dd0tcrM123"
    And I press "Log In"
    Then I should see "Log Out"
    And I should see "Home"

  @javascript
  Scenario: Logs in to the site
    Given I am on "/index.php"
    When I fill in "user_name" with "admin"
    And I fill in "user_password" with "R3dd0tcrM123"
    And I press "Log In"
    And I follow "Survey"
    And I follow "Bank Survey"
    And I wait sometime
    Then I should see " Search Bank Survey "
    And I should see "Create Bank Survey"
