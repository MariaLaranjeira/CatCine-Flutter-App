Feature: Users can Sign In in the system back to their accounts
  Scenario: User signs in
    Given there is a "emailBox" field, a "passwordBox" field and a "signInButton" button
    When the user fills the "emailBox" with "testing@test.com"
    And the user fills "passwordBox" with "test"
    And the user clicks the "signInButton"
    Then it is expected the field "explore" to be present
