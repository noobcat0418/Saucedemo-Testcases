*** Comments ***
# Inventory Keywords
# This file contains keywords related to inventory/products page functionality.

*** Settings ***
Library     SeleniumLibrary
Library     Collections
Resource    common_keywords.resource
Resource    ../locators/inventory_locators.resource

*** Keywords ***
Verify Products Are Displayed
    [Documentation]    Verifies that products are displayed on the inventory page.
    ...                Checks for product names, descriptions, prices, and images.
    ${names}=    Get WebElements    ${INVENTORY_ITEM_NAME}
    Should Not Be Empty    ${names}    No products found on the inventory page.
    ${name_count}=    Get Length    ${names}
    Log    Found ${name_count} products on inventory page

    ${descriptions}=    Get WebElements    ${INVENTORY_ITEM_DESC}
    ${desc_count}=    Get Length    ${descriptions}
    Should Be Equal As Numbers    ${desc_count}    ${name_count}    Product descriptions count mismatch

    ${prices}=    Get WebElements    ${INVENTORY_ITEM_PRICE}
    ${price_count}=    Get Length    ${prices}
    Should Be Equal As Numbers    ${price_count}    ${name_count}    Product prices count mismatch

    ${images}=    Get WebElements    ${INVENTORY_ITEM_IMAGE}
    ${img_count}=    Get Length    ${images}
    Should Be True    ${img_count} >= ${name_count}    Product images count mismatch

    ${first_name}=    Get Text    ${names}[0]
    ${first_desc}=    Get Text    ${descriptions}[0]
    ${first_price}=    Get Text    ${prices}[0]
    Log    Sample Product: ${first_name} - ${first_desc} - ${first_price}

Verify Products Count
    [Documentation]    Verifies the number of products displayed on the page.
    [Arguments]    ${expected_count}
    ${products}=    Get WebElements    ${INVENTORY_ITEM}
    ${actual_count}=    Get Length    ${products}
    Should Be Equal As Numbers    ${actual_count}    ${expected_count}

Add Product To Cart By Button
    [Documentation]    Adds a product to cart using its add-to-cart button locator.
    [Arguments]    ${add_button_locator}
    Wait For Element And Click    ${add_button_locator}
    Sleep    0.5s

Add All Products To Cart
    [Documentation]    Adds all 6 products to the shopping cart.
    Dismiss Browser Popups
    Click Element    ${ADD_BACKPACK_BTN}
    Click Element    ${ADD_BIKE_LIGHT_BTN}
    Click Element    ${ADD_BOLT_TSHIRT_BTN}
    Click Element    ${ADD_FLEECE_JACKET_BTN}
    Click Element    ${ADD_ONESIE_BTN}
    Click Element    ${ADD_RED_TSHIRT_BTN}
    ${remove_buttons}=    Get WebElements    ${REMOVE_BUTTON_PATTERN}
    ${items_added}=    Get Length    ${remove_buttons}
    Log    Added ${items_added} items to cart
    RETURN    ${items_added}

Sort Products By Option
    [Documentation]    Sorts products by the specified sort option value.
    [Arguments]    ${sort_value}
    Select From List By Value    ${PRODUCT_SORT_CONTAINER}    ${sort_value}
    Wait Until Element Is Visible    ${INVENTORY_ITEM_NAME}    ${DEFAULT_TIMEOUT}

Sort Products By Name Ascending
    [Documentation]    Sorts products by Name (A to Z).
    Sort Products By Option    ${SORT_NAME_AZ}

Sort Products By Name Descending
    [Documentation]    Sorts products by Name (Z to A).
    Sort Products By Option    ${SORT_NAME_ZA}

Sort Products By Price Low To High
    [Documentation]    Sorts products by Price (low to high).
    Sort Products By Option    ${SORT_PRICE_LOW_HIGH}

Sort Products By Price High To Low
    [Documentation]    Sorts products by Price (high to low).
    Sort Products By Option    ${SORT_PRICE_HIGH_LOW}

Get Product Price By Index
    [Documentation]    Gets the price of a product by its index on the inventory page.
    [Arguments]    ${index}
    ${prices}=    Get WebElements    ${INVENTORY_ITEM_PRICE}
    ${price_text}=    Get Text    ${prices}[${index}]
    ${price_value}=    Extract Price Value    ${price_text}
    RETURN    ${price_value}

Remove Product From Inventory
    [Documentation]    Removes a product from cart using its remove button locator.
    [Arguments]    ${remove_button_locator}
    Click Element    ${remove_button_locator}
    Sleep    0.5s
