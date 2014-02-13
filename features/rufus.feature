@rufus
Feature: Using Rufus

  Background:
    Given I am on the "HomePage"

  Scenario: Getting an element by name without accessor
    Then I do not need an accessor to find the view defined "rufusButton"

  Scenario: Clicking on an element by name without accessor
    Given I have clicked on view defined "rufusButton" with an accessor
    Then I am on the "RufusPage"
 @jls
  Scenario: Getting the page source
    Then I can print out the page data

  Scenario: Getting page elements by class
    Then I can get a list of the buttons

  Scenario: Waiting for a view defined by a hash to be enabled
    Given I have navigated to the "EnabledPage" using the "to_enabled" route
    Then I can use a hash to wait for "enabledTextField" to become enabled
    And I see that the "notEnabledTextField" is never enabled

  Scenario: Waiting for a view defined by a hash to exist
    Given I have navigated to the "ExistsPage" using the "to_exists" route
    Then I can use a hash to wait for the "This Alert Exists" view to exist

  Scenario: Waiting for a view defined by a hash to be displayed
    Given I have navigated to the "DisplayedPage" using the "to_displayed" route
    Then I can use a hash to wait for the "Mystery Label" to be displayed
    And I see that the "Invisible Label" is never displayed