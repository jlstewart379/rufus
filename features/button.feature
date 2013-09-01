Feature: Interacting with views

  Scenario: Using a view to define a page
    Given I am on the HomePage

  Scenario: Clicking views
    Given I am on the HomePage
    When I click the view defined "rufus"
    Then I am on the "SecondPage"

  Scenario: Getting a view by text
    Given I am on the HomePage
    Then I can find the "rufus" view defined by "text"
