*** Comments ***
# US002: Manage Shopping Cart
# Test suite for verifying shopping cart management functionality.

*** Settings ***
Documentation    Test suite for managing shopping cart on Saucedemo.
...              Covers adding products, verifying cart contents, removing products,
...              and validating price calculations during checkout.

Library          SeleniumLibrary
Library          Collections

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource
Resource         ../resources/keywords/cart_keywords.resource
Resource         ../resources/keywords/checkout_keywords.resource

Resource         ../data/test_data.resource
Resource         ../resources/locators/inventory_locators.resource
Resource         ../resources/locators/cart_locators.resource
Resource         ../resources/locators/checkout_locators.resource

Suite Setup      Open Browser And Maximize    ${BASE_URL}
Suite Teardown   Close Browser

*** Variables ***
${PRODUCT_1_PRICE}    ${0}
${PRODUCT_2_PRICE}    ${0}

*** Test Cases ***
Manage Shopping Cart
    [Documentation]    Verify that users can manage their shopping cart,
    ...                add/remove products, and see correct price calculations.
    [Tags]    smoke    cart    checkout

    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Add Products To Cart
    Save Product Prices From Inventory
    Navigate To Cart
    Verify Cart Contains Correct Products
    Remove First Product And Proceed To Checkout
    Fill Checkout Information    ${CHECKOUT_FIRST_NAME}    ${CHECKOUT_LAST_NAME}    ${CHECKOUT_POSTAL_CODE}
    Verify Total Price Updates After Product Removal

*** Keywords ***
Add Products To Cart
    [Documentation]    Adds the first two products to the shopping cart.
    Wait Until Element Is Visible    ${INVENTORY_ITEM}    ${DEFAULT_TIMEOUT}
    Add Product To Cart By Button    ${ADD_BACKPACK_BTN}
    Add Product To Cart By Button    ${ADD_BIKE_LIGHT_BTN}
    Wait Until Element Is Visible    ${CART_BADGE}    5s
    Log    Products added to cart

Save Product Prices From Inventory
    [Documentation]    Saves the prices of the first two products from inventory page.
    ${price1}=    Get Product Price By Index    0
    ${price2}=    Get Product Price By Index    1
    Set Suite Variable    ${PRODUCT_1_PRICE}    ${price1}
    Set Suite Variable    ${PRODUCT_2_PRICE}    ${price2}
    Log    Product 1 price: ${PRODUCT_1_PRICE}
    Log    Product 2 price: ${PRODUCT_2_PRICE}

Verify Cart Contains Correct Products
    [Documentation]    Verifies cart displays correct products with quantities and prices.
    Verify Cart Item Count    2
    Verify Product In Cart    ${PRODUCT_BACKPACK}
    Verify Product In Cart    ${PRODUCT_BIKE_LIGHT}
    Verify Product Quantity In Cart    ${PRODUCT_BACKPACK}    1
    Verify Product Quantity In Cart    ${PRODUCT_BIKE_LIGHT}    1

    ${cart_price1}=    Get Cart Product Price    ${PRODUCT_BACKPACK}
    ${cart_price2}=    Get Cart Product Price    ${PRODUCT_BIKE_LIGHT}
    Should Be Equal As Numbers    ${PRODUCT_1_PRICE}    ${cart_price1}
    Should Be Equal As Numbers    ${PRODUCT_2_PRICE}    ${cart_price2}

Remove First Product And Proceed To Checkout
    [Documentation]    Removes the first product from cart and proceeds to checkout.
    Remove Product From Cart By Name    ${REMOVE_BACKPACK_BTN}
    Click Checkout Button

Verify Total Price Updates After Product Removal
    [Documentation]    Verifies total price is updated correctly when products are removed.
    ...                This test adds more products, checks totals, and validates price calculations.

    # Go back to inventory and add more products
    Cancel Checkout
    Navigate To Cart
    Click Continue Shopping

    # Add products again for price verification
    Wait Until Element Is Visible    ${INVENTORY_ITEM}    ${DEFAULT_TIMEOUT}
    Add Product To Cart By Button    ${ADD_BACKPACK_BTN}
    Add Product To Cart By Button    ${ADD_BOLT_TSHIRT_BTN}

    # Get prices from inventory
    ${price1}=    Get Product Price By Index    0
    ${price3}=    Get Product Price By Index    2
    Log    Product 1 price: ${price1}
    Log    Product 3 price: ${price3}

    # Proceed to checkout
    Navigate To Cart
    Click Checkout Button
    Fill Checkout Information    ${CHECKOUT_FIRST_NAME}    ${CHECKOUT_LAST_NAME}    ${CHECKOUT_POSTAL_CODE}

    # Get initial total and tax
    ${initial_total}=    Get Summary Total
    ${initial_tax}=    Get Summary Tax
    Log    Initial total price: ${initial_total}
    Log    Initial tax: ${initial_tax}

    # Go back and remove a product
    Cancel Checkout
    Navigate To Cart
    Remove Product From Cart By Name    ${REMOVE_BACKPACK_BTN}
    Click Checkout Button

    Fill Checkout Information    ${CHECKOUT_FIRST_NAME}    ${CHECKOUT_LAST_NAME}    ${CHECKOUT_POSTAL_CODE}

    # Get updated total
    ${updated_total}=    Get Summary Total
    ${updated_tax}=    Get Summary Tax
    Log    Updated total price: ${updated_total}
    Log    Updated tax: ${updated_tax}

    # Validate that totals are different after removal
    Should Not Be Equal As Numbers    ${updated_total}    ${initial_total}
    Log    Price correctly updated after removing product
