Feature: Users can register in the system
  Scenario: User signs in
    Given an user clicks the "signInButton" button
    Then the user is redirected to the "SignInPage"
    Given there is an "emailBox", a "passwordBox" and a "singInButton"
    When the user fills the "emailBox" with "test@testing.com"
    And the user fills "passwordBox" with "testing"
    When the user clicks the "signInButton"
    Then they will be redirected to the "explorePage"