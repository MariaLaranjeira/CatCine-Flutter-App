Feature: Users can navigate to the Register Page
  Scenario: User enters Register Page
    Given there is a "registerButton" button
    And an user clicks the "registerButton" button
    Then I expect the "catnameBox" to be present