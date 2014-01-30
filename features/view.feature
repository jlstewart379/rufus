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
    And the view marked "invisible" exists but is not displayed

  Scenario: Waiting for a view to be enabled
    Given I have navigated to the "EnabledPage" using the "to_enabled" route
    Then I am on the "EnabledPage"
    And the view marked "not_enabled" is not enabled

   Scenario: Calling views in a block
     Given I am on the "HomePage"
     Then in a block can see the existence of views "rufus", "exists" and "displayed"

   Scenario: Getting text of a view
     Given I am on the "HomePage"
     Then I can see the view defined "label" has text "Rufus Label"

   Scenario: Getting the class of a view
     Given I have created a valid appium driver for iOS
     And I am on the "HomePage"
     Then I can determine the view defined "label" is of type "UIAStaticText"

   Scenario: Getting a view by label
     Given I click the view defined "labeled"
     Then I am on the "LabeledPage"

