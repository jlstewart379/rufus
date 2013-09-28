Feature: Interacting with alerts

  Scenario: Getting the title of an alert view
    Given I am on the "HomePage"
    When I click the view defined "show_alert"
    Then I see the title of the alert defined "alert" is "Rufus Alert"