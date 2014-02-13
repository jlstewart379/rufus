@driver
Feature: Interacting with hardware

  Scenario: Configuring for iOS
    Given I have created a valid appium driver for iOS

  Scenario: Rotating the orientation of device to landscape
    Given the app is in the "portrait" orientation
    When I rotate the app to "landscape"
    Then the app is in the "landscape" orientation

  Scenario: Rotating the orientation twice
    Given the app is in the "portrait" orientation
    When I rotate the app to "landscape"
    And I rotate the app to "portrait"
    Then the app is in the "portrait" orientation

  Scenario: Typing into a text field
    Given I am on the "HomePage"
    When I type "BooYah" into the text field defined "text_box"
    Then the view marked "text_box" has the text "BooYah"
  @jls
  Scenario: Taking a screenshot
    Given I have created a valid appium driver for iOS
    When I take a screenshot called "coolShot.png"
    Then then the file "coolShot.png" exists
