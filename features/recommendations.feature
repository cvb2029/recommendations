Feature: The recommendation service back-end
    As a eCommerce web site Owner
    I need a RESTful catalog service
    So that I can keep track of all my recommendations

Background:
    Given the following recommendations
        | name       | original_product_id | recommendation_product_name | recommendation_product_id  | reason     | activated |
        | desk       | 1                   | chair                       | 5                          | CROSS_SELL | True      |
        | mouse      | 2                   | keyboard                    | 6                          | UP_SELL    | True      |
        | jelly      | 3                   | beans                       | 7                          | OTHER      | False     |
        | tea        | 4                   | mug                         | 8                          | ACCESSORY  | True      |

Scenario: The server is running
    When I visit the "Home Page"
    Then I should see "Recommendation Demo RESTful Service" in the title
    And I should not see "404 Not Found"

Scenario: Create a Recommendation
    When I visit the "Home Page"
    And I set the "Name" to "couch"
    And I set the "original_product_id" to "9"
    And I set the "recommendation_product_name" to "tv"
    And I set the "recommendation_product_id" to "10"
    And I select "UP_SELL" in the "Reason" dropdown
    And I select "True" in the "Activated" dropdown
    And I press the "Create" button
    Then I should see the message "Success"
    When I copy the "Id" field
    And I press the "Clear" button
    Then the "Id" field should be empty
    And the "Name" field should be empty
    And the "original_product_id" field should be empty
    And the "recommendation_product_name" field should be empty
    And the "recommendation_product_id" field should be empty
    When I paste the "Id" field
    And I press the "Retrieve" button
    Then I should see "couch" in the "Name" field
    And I should see "9" in the "original_product_id" field
    And I should see "tv" in the "recommendation_product_name" field
    And I should see "10" in the "recommendation_product_id" field
    And I should see "UP_SELL" in the "Reason" dropdown
    And I should see "True" in the "Activated" dropdown

Scenario: List all pets
    When I visit the "Home Page"
    And I press the "Search" button
    Then I should see "desk" in the results
    And I should see "mouse" in the results
    And I should not see "jelly" in the results
    And I should not see "tea" in the results

Scenario: Search for dogs
    When I visit the "Home Page"
    And I set the "recommendation_product_name" to "chair"
    And I press the "Search" button
    Then I should see "desk" in the results

Scenario: Search for available
    When I visit the "Home Page"
    And I select "True" in the "Activated" dropdown
    And I press the "Search" button
    Then I should see "desk" in the results
    And I should see "mouse" in the results
    And I should not see "tea" in the results

Scenario: Update a Pet
    When I visit the "Home Page"
    And I set the "Name" to "desk"
    And I press the "Search" button
    Then I should see "desk" in the "Name" field
    And I should see "chair" in the "recommendation_product_name" field
    When I change "Name" to "lamp"
    And I press the "Update" button
    Then I should see the message "Success"
    When I copy the "Id" field
    And I press the "Clear" button
    And I paste the "Id" field
    And I press the "Retrieve" button
    Then I should see "lamp" in the "Name" field
    When I press the "Clear" button
    And I press the "Search" button
    Then I should see "lamp" in the results
    Then I should not see "desk" in the results