Feature: Conjur "connect" method works if the username is known

  Scenario: Connecting to Conjur fails without the username
    Then I cannot connect to Conjur

  Scenario: Connecting to Conjur succeeds when the username is in the environment
  	Given I configure the Conjur username
    Then I can connect to Conjur
    And I can list Conjur resources
