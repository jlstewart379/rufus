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

  Scenario: Waiting for a view to exist
    Given I have navigated to the "ExistsPage" using the "to_exists" route
    Then I am on the "ExistsPage"

  Scenario: Waiting for a view that is not there
    Given I am on the "HomePage"
    Then I will not find the view marked "zilch" after waiting

  Scenario: Waiting for a view to be displayed
    Given I have navigated to the "DisplayedPage" using the "to_displayed" route
    Then I am on the "DisplayedPage"
