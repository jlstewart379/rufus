@swipe
Feature: Swiping the screen

  Scenario: Swiping to the right
    Given I have navigated to the "SwipePage" using the "to_swipe" route
    When I swipe to the right on the view defined "Screen #0"
    Then I can see I swiped to the view named "Screen #1"
