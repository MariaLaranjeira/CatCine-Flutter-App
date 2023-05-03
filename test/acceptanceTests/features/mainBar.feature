Feature: Users can navigate through the Main Bar
  Scenario: User taps a Main Bar button
    Given there is a "homeButton" button, a "profileButton" button, a "createCategoryButton" button, a "exploreButton" button and a "exploreCategoryButton" button
    When the user taps the "exploreButton"
    Then it is expected the field "explore" to be present