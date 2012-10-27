Feature: Login
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

  Scenario: User can login to the system
    Given I am on sign in page
    When I fill in "Email" with "testing_user@gmail.com"
    When I fill in "Password" with "123456"
    And I click the button submit
    Then I should be on my dashboard