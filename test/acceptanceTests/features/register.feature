Feature: Users can register in the system
  Scenario: User registers
    Given there is a "catnameBox", an "emailBox", a "passwordBox", a "confirmPasswordBox", and a "registerButton"
    When the user fills the "catnameBox" with "test"
    And the user fills the "emailBox" with "test@testing.com"
    And the user fills "passwordBox" with "testing"
    And the user fills "confirmPasswordBox" with "testing"
    And the user clicks the "registerButton"
    Then I expect the "explore" to be present