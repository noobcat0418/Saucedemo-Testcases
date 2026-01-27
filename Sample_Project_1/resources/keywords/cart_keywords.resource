*** Comments ***
# Cart Keywords
# This file contains keywords related to shopping cart functionality.

*** Settings ***
Library     SeleniumLibrary
Library     Collections
Resource    common_keywords.resource
Resource    ../locators/cart_locators.resource
Resource    ../locators/inventory_locators.resource

*** Keywords ***
Navigate To Cart
    [Documentation]    Clicks on the cart icon to navigate to the cart page.
    Click Element    ${CART_ICON}
    Wait Until Element Is Visible    ${CHECKOUT_BTN}    ${DEFAULT_TIMEOUT}

Verify Cart Badge Count
    [Documentation]    Verifies the shopping cart badge displays the correct count.
    [Arguments]    ${expected_count}
    Wait Until Element Is Visible    ${CART_BADGE}    ${DEFAULT_TIMEOUT}
    ${cart_text}=    Get Text    ${CART_BADGE}
    Should Be Equal As Strings    ${cart_text}    ${expected_count}    Cart count does not match items added

Verify Cart Item Count
    [Documentation]    Verifies the number of items in the cart.
    [Arguments]    ${expected_count}
    ${products}=    Get WebElements    ${CART_ITEM}
    ${product_count}=    Get Length    ${products}
    Should Be Equal As Integers    ${product_count}    ${expected_count}

Verify Product In Cart
    [Documentation]    Verifies a specific product is present in the cart.
    [Arguments]    ${product_name}
    ${locator}=    Set Variable    xpath=//div[contains(@class, 'inventory_item_name') and text()='${product_name}']
    Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
    ${cart_product}=    Get Text    ${locator}
    Should Be Equal    ${cart_product}    ${product_name}

Verify Product Quantity In Cart
    [Documentation]    Verifies the quantity of a specific product in the cart.
    [Arguments]    ${product_name}    ${expected_quantity}
    ${quantity_locator}=    Set Variable    xpath=//div[contains(text(), '${product_name}')]/preceding::div[contains(@class, 'cart_quantity')][1]
    ${quantity}=    Get Text    ${quantity_locator}
    Should Be Equal    ${quantity}    ${expected_quantity}

Get Cart Product Price
    [Documentation]    Gets the price of a specific product in the cart.
    [Arguments]    ${product_name}
    ${price_locator}=    Set Variable    xpath=//div[contains(text(), '${product_name}')]/following::div[contains(@class, 'inventory_item_price')][1]
    ${price_text}=    Get Text    ${price_locator}
    ${price_value}=    Extract Price Value    ${price_text}
    RETURN    ${price_value}

Remove Product From Cart By Name
    [Documentation]    Removes a product from the cart using its remove button.
    [Arguments]    ${remove_button_locator}
    Click Element    ${remove_button_locator}
    Sleep    1s

Click Continue Shopping
    [Documentation]    Clicks the Continue Shopping button to return to inventory.
    Click Element    ${CONTINUE_SHOPPING_BTN}
    Wait Until Element Is Visible    ${INVENTORY_ITEM}    ${DEFAULT_TIMEOUT}

Click Checkout Button
    [Documentation]    Clicks the Checkout button to proceed to checkout.
    Wait Until Element Is Visible    ${CHECKOUT_BTN}    ${DEFAULT_TIMEOUT}
    Click Element    ${CHECKOUT_BTN}
