@swipe
Feature: Swiping the screen
  
  Background:
    Given I rotate the app to "portrait"

  Scenario: Swiping to the right
    Given I have navigated to the "ScrollPage" using the "to_scroll" route
    When I scroll to the right on the view defined "Screen #3"
    Then I can see I scrolled to the view named "Screen #3"
