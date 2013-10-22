@table
Feature: dealing with tables
  
  Background: 
    Given I have navigated to the "TablePage" using the "to_tables" route


  Scenario: Checking the sort
    Then I see the table defined "sorted" is sorted
@children
  Scenario: Getting the child elements
    Then I can see all the children for the view defined "sorted"