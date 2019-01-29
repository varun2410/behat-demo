Feature: Check crm api's

Scenario: Check ppv receive api
Given I want to call "/1.0/ppvlogistic"
When I give set username as "ppvuser" and password as "ppvpassword"
And I add in json data
And I set verb as "POST"
And I create authorization header
And I call the api
Then I should get json response