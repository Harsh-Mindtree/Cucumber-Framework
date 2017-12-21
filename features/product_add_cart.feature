@ProductInCartFeature
Feature: User want to check if product added into cart

  Scenario: User check the product into cart
	Given I am on Amazon Home Page
	When I login into Amazon
    Then The added product should be present in the Cart