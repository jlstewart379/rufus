Feature: Interacting with views

   Scenario:  Clicking a view
    Given I am on the "HomePage"
    When I click the view defined "rufus"
    Then I am on the "RufusPage"
