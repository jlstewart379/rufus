@view
Feature: Interacting with views

   Scenario:  Clicking a view
    Given I am on the "HomePage"
    When I click the view defined "rufus"
    Then I am on the "RufusPage"

   Scenario: Finding a view
     Given I am on the "HomePage"
     Then the view defined "rufus" does exist

  Scenario: Not finding a view
    Given I am on the "HomePage"
    Then the view defined "zilch" does not exist
