@swipe
Feature: Swiping the screen

  Scenario: Swiping to the right
    Given I have navigated to the "SwipePage" using the "to_swipe" route
    When I swipe to the right 1 time
    Then I can see the label "Screen #1"
