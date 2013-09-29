Feature: Interacting with alerts

  Background:
    Given I am on the "HomePage"
    When I click the view defined "show_alert"

  Scenario: Getting the title of an alert view
    Then I see the title of the alert defined "alert" is "Rufus Alert"

  Scenario: Selecting action button in alert view
    And I select the "Ok" button on the alert defined "alert"
    Then I am on the "RufusPage"

  Scenario: Selecting cancel button in alert view
    And I select the "Cancel" button on the alert defined "alert"
    Then I am on the "HomePage"