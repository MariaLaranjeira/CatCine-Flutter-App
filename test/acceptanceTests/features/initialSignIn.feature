Feature: Users can navigate to Sign In Page
  Scenario: User enters Sign In Page
    Given there is a "signInButton" button
    When the User taps the "signInButton" button
    Then it is expected the field "emailField" to be present