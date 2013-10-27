@table
Feature: dealing with tables
  
  Background: 
    Given I have navigated to the "TablePage" using the "to_tables" route

  Scenario: Checking the sort
    Then I see the table defined "ascending" is sorted
    And I see the table defined "descending" is sorted
    And I see the table defined "unsorted" is not sorted

  Scenario: Getting the child elements
    Then I can see all the children for the view defined "ascending"

    @index
  Scenario: Selecting and item by index
   Given I select index "4" of the "ascending" table
   Then I am on the "LabelAPage"
