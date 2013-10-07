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
  @exists
  Scenario: Waiting for a view to exist
    Given I have navigated to the "ExistsPage" using the "to_exists" route
    Then I am on the "ExistsPage"
