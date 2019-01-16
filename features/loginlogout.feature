Feature: Log in and out of the site
  In order to maintain an account
    As a site visitor
    I need to log in and out of the site.

@javascript
Scenario: Logs in to the site
  Given I am on "/login.html"
  When I fill in "email" with "offcld1@gmail.com"
    And I fill in "pass" with "Qwezxcasd24@"
    And I press "Log In"
  Then I should see "LogOut"
    And I should see "My Profile"


# Require a real browser. Will use Selenium/Firefox (or Zombie or Sahi).
@javascript
Scenario: Logs out of the site
  Given I am on "/login.html"
  When I fill in "email" with "offcld1@gmail.com"
    And I fill in "pass" with "Qwezxcasd24@"
    And I press "Log In"
    And I follow "LogOut"
  Then I should see "Log In"
    And I should not see "My Profile"

@javascript
Scenario: Attempts wo login with wrong credentials
  Given I am on "/login.html"
  When I fill in "email" with "offcld@gmail.com"
  And I fill in "pass" with "Qwezxcasd24@"
  And I press "Log In"
  Then I should see Alert "Wrong Username Or Password"
  And I should not see "My Profile"
