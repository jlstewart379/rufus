@rufus
Feature: Using Rufus

  Background:
    Given I am on the "HomePage"

  Scenario: Getting an element by name without accessor
    Then I do not need an accessor to find the view defined "rufusButton"

  Scenario: Clicking on an element by name without accessor
    Given I have clicked on view defined "rufusButton" with an accessor
    Then I am on the "RufusPage"

  Scenario: Getting the page source
    Then I can print out the page data


