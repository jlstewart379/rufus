Feature: Interacting with views
  There are some things here that we can use

  Background: Launch
    Given I start the driver

    Scenario:  Clicking a view
    Given I am on the HomePage
    When I click the view defined "rufus"
    Then I am on the "RufusPage"

