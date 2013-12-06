@optimized_ios_driver
Feature: Using the page_source optimizer

Background:
  Given I have created an optimized driver for iOS

  Scenario: Waiting for a view to exist
    Given I am on the "HomePage"
    Then I can see the view defined "label" has text "Rufus Label"