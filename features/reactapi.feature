Feature: Log in and out of the site
  In order to maintain an account
  As a site visitor
  I need to log in and out of the site.

  @javascript
  Scenario: Logs in to the site
    Given I am on "/login"
    When I fill in "username" with "tablet"
    And I fill in "password" with "mindfire"
    And I press "Log In"
    Then I should see "LogOut"
    And I should see "Home"


# Require a real browser. Will use Selenium/Firefox (or Zombie or Sahi).
  @javascript
  Scenario: Logs out of the site
    Given I am on "/login"
    When I fill in "username" with "tablet"
    And I fill in "password" with "mindfire"
    And I press "Log In"
    And I follow "Logout"
    Then I should see "Login To Continue"
    And I should not see "Home"

  @javascript
  Scenario: Logs in with invalid user name
    Given I am on "/login"
    When I fill in "username" with "tablet1"
    And I fill in "password" with "mindfire"
    And I press "Log In"
    Then I should see "Invalid Credentials"
    And I should see "Login To Continue"

  @javascript
  Scenario: Check if users api is working
    Given I am on "/login"
    When I fill in "username" with "tablet"
    And I fill in "password" with "mindfire"
    And I press "Log In"
    And I follow "Users"
    Then I should see "Users"
    And I should see "Varun"

  @javascript
  Scenario: Check if users api is working
    Given I am on "/login"
    When I fill in "username" with "tablet"
    And I fill in "password" with "mindfire"
    And I press "Log In"
    And I follow "Users"
    And I press "Add Users"
    And I fill in "firstName" with "Kratos"
    And I fill in "lastName" with "GOW"
    And I fill in "department" with "PHP"
    And I fill in "phoneNumber" with "12345678"
    And I press "Save"
    And I follow "Users"
#    Then I should see a Toastr with "Course Saved"
    Then I should see "Kratos"