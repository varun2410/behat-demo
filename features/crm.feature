Feature: Log in and out of the site
  In order to maintain an account
  As a site visitor
  I need to log in and out of the site.

#  @javascript
#  Scenario: Logs in to the site
#    Given I am on "/login.aspx"
#    When I fill in "txtName" with "varuna"
#    And I fill in "txtPassword" with "honey24"
#    And I press "Login"
#    Then I should see "Logout"

  @javascript
  Background: Logs in to the site
    Given I am on "/index.php"
    When I fill in "user_name" with "admin"
    And I fill in "user_password" with "R3dd0tcrM123"
    And I press "Log In"
    Then I should see "Log Out"

  @javascript
  Scenario: Logs out of site
    Then I follow "Log Out"
    And I should not see "Home"

  @javascript
  Scenario: Check for bank survey module
    Then I follow "Survey"
    And I follow "Bank Survey"
    And I wait sometime
    Then I should see " Search Bank Survey "
    And I should see "Create Bank Survey"

  @javascript
  Scenario: Check for bank survey module
    Then I follow "Survey"
    And I follow "Bank Survey"
    And I wait sometime
    And I fill in "accounts_bank_survey_1_name_basic" with "915058120050226"
    And I press "search_form_submit"
    And I wait sometime
    Then I should see "181"