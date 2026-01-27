*** Comments ***
# US001: View And Sort Products
# Test suite for verifying product display and sorting functionality.

*** Settings ***
Documentation    Test suite for viewing and sorting products on the Saucedemo inventory page.
...              Covers product display verification, add to cart functionality, and sorting options.

Library          SeleniumLibrary
Library          Collections

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource
Resource         ../resources/keywords/cart_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/inventory_locators.resource
Resource         ../resources/locators/cart_locators.resource

Suite Setup      Open Browser And Maximize    ${BASE_URL}
Suite Teardown   Close Browser

*** Variables ***
${ITEMS_ADDED}    0

*** Test Cases ***
View And Sort Products
    [Documentation]    Test to verify products are displayed correctly and all sorting options work.
    [Tags]    smoke    products    sorting

    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Products Are Displayed
    Verify Add To Cart Functionality
    Verify Cart Badge Shows Correct Count
    Sort Products By Name Ascending
    Sort Products By Name Descending
    Sort Products By Price Low To High
    Sort Products By Price High To Low

*** Keywords ***
Verify Add To Cart Functionality
    [Documentation]    Verifies that all products can be added to the cart.
    ${items_added}=    Add All Products To Cart
    Set Suite Variable    ${ITEMS_ADDED}    ${items_added}
    Log    Successfully added ${items_added} items to cart

Verify Cart Badge Shows Correct Count
    [Documentation]    Verifies the cart badge displays the correct number of items.
    Verify Cart Badge Count    ${ITEMS_ADDED}
