Feature: Automatic red pencil promotion status evaluation for items

  Background:  I have an item that I am selling with a base price of $100.00
    Given I have an item for sale on the website

  Scenario: Red pencil promotion is triggered when price is reduced between 5% and 30% and price has not previously changed in 30 days
    Given the price of my item was last changed 31 days ago
    And my item is not currently marked as a red pencil promotion
    When I reduce the price of my item by 15%
    Then the item should now be tagged as a red pencil promotion

  Scenario: Red pencil promotion not triggered when price is reduced between 5% and 30% but price has previously changed in the last 30 days
    Given the price of my item was last changed 15 days ago
    And my item is not currently marked as a red pencil promotion
    When I reduce the price of my item by 15%
    Then the item should not be tagged as a red pencil promotion

  Scenario: Red pencil promotion is cancelled if price reduction brings current price to more than 30% off
    Given my item is currently marked as a red pencil promotion
    When I reduce the price of my item by 40%
    Then the item should not be tagged as a red pencil promotion

  Scenario: Red pencil promotion is discontinued after 30 days
    Given my item has been marked as a red pencil promotion for 30 days
    When another day passes during the promotion
    Then the item should not be tagged as a red pencil promotion

  Scenario:  Further price reduction during red pencil promotion does not reset length of promotion
    Given my item has been marked as a red pencil promotion for 15 days
    When I reduce the price of my item by 10%
    Then the item should now be tagged as a red pencil promotion
    But the last promotion start date should be 15 days ago

  Scenario:  An increase in price during a red pencil promotion will automatically cancel the promotion
    Given my item is currently marked as a red pencil promotion
    When I increase the price of my item by 10%
    Then the item should not be tagged as a red pencil promotion

  Scenario:  Further price reduction during red pencil promotion that increases overall reduction to over 30% will automatically cancel the promotion
    Given I reduce the price of my item by 25%
    And the item should now be tagged as a red pencil promotion
    When I reduce the price of my item by 25%
    Then the item should not be tagged as a red pencil promotion

  Scenario:  New red pencil promotion may be activated after previous red pencil promotion as long as 30 days have passed since last price change and promotion start date
    Given the price of my item was last changed 31 days ago
    And the last promotion start date was 31 days ago
    And my item is not currently marked as a red pencil promotion
    When I reduce the price of my item by 15%
    Then the item should now be tagged as a red pencil promotion