Feature: Automatic red pencil promotion status evaluation for items

  Scenario: Red pencil promotion is triggered when price is reduced between 5% and 30% and price has not previously changed in 30 days
    Given I have an item for sale on the website
    And the price of my item was last changed 31 days ago
    And my item is not currently marked as a red pencil promotion
    When I reduce the price of my item by 15%
    Then the item should now be tagged as a red pencil promotion


  Scenario: Red pencil promotion not triggered when price is reduced between 5% and 30% but price has previously changed in the last 30 days
    Given I have an item for sale on the website
    And the price of my item was last changed 15 days ago
    And my item is not currently marked as a red pencil promotion
    When I reduce the price of my item by 15%
    Then the item should not be tagged as a red pencil promotion