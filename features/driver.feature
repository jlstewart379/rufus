@driver
Feature: Interacting with a view

  Scenario: Configuring for iOS
    Given I have created a valid appium driver for iOS

  Scenario: Rotating the orientation of device to landscape
    Given the app is in the "landscape" orientation
    When I rotate the app to "portrait"
    Then the app is in the "portrait" orientation

  Scenario: Rotating the orientation twice
    Given the app is in the "landscape" orientation
    When I rotate the app to "portrait"
    And I rotate the app to "landscape"
    Then the app is in the "landscape" orientation

