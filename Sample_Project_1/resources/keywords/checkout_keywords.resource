*** Comments ***
# Checkout Keywords
# This file contains keywords related to checkout functionality.

*** Settings ***
Library     SeleniumLibrary
Resource    common_keywords.resource
Resource    ../locators/checkout_locators.resource
Resource    ../locators/cart_locators.resource
Resource    ../locators/inventory_locators.resource

*** Keywords ***
Fill Checkout Information
    [Documentation]    Fills the checkout information form with provided details.
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Wait Until Element Is Visible    ${CHECKOUT_FIRST_NAME_INPUT}    ${DEFAULT_TIMEOUT}
    Input Text    ${CHECKOUT_FIRST_NAME_INPUT}    ${first_name}
    Input Text    ${CHECKOUT_LAST_NAME_INPUT}    ${last_name}
    Input Text    ${CHECKOUT_POSTAL_CODE_INPUT}    ${postal_code}
    Click Button    ${CHECKOUT_CONTINUE_BTN}

Cancel Checkout
    [Documentation]    Clicks the Cancel button on checkout page.
    Wait Until Element Is Visible    ${CHECKOUT_CANCEL_BTN}    ${DEFAULT_TIMEOUT}
    Click Element    ${CHECKOUT_CANCEL_BTN}

Get Summary Subtotal
    [Documentation]    Gets the subtotal amount from checkout summary.
    Wait Until Element Is Visible    ${SUMMARY_SUBTOTAL}    ${DEFAULT_TIMEOUT}
    ${subtotal_text}=    Get Text    ${SUMMARY_SUBTOTAL}
    ${subtotal_value}=    Extract Total Price Value    ${subtotal_text}
    RETURN    ${subtotal_value}

Get Summary Tax
    [Documentation]    Gets the tax amount from checkout summary.
    Wait Until Element Is Visible    ${SUMMARY_TAX}    ${DEFAULT_TIMEOUT}
    ${tax_text}=    Get Text    ${SUMMARY_TAX}
    ${tax_value}=    Extract Total Price Value    ${tax_text}
    RETURN    ${tax_value}

Get Summary Total
    [Documentation]    Gets the total amount from checkout summary.
    Wait Until Element Is Visible    ${SUMMARY_TOTAL}    ${DEFAULT_TIMEOUT}
    ${total_text}=    Get Text    ${SUMMARY_TOTAL}
    ${total_value}=    Extract Total Price Value    ${total_text}
    RETURN    ${total_value}

Finish Checkout
    [Documentation]    Clicks the Finish button to complete the order.
    Click Element    ${FINISH_BTN}
    Wait Until Element Is Visible    ${CHECKOUT_COMPLETE_HEADER}    ${DEFAULT_TIMEOUT}

Verify Checkout Complete
    [Documentation]    Verifies that the checkout was completed successfully.
    ${header}=    Get Text    ${CHECKOUT_COMPLETE_HEADER}
    Should Contain    ${header}    Thank you for your order

Return To Products From Checkout
    [Documentation]    Clicks Back Home button after checkout completion.
    Click Element    ${BACK_HOME_BTN}
    Wait Until Element Is Visible    ${INVENTORY_ITEM}    ${DEFAULT_TIMEOUT}

Verify Total Price After Removal
    [Documentation]    Verifies total price updates correctly after removing a product.
    [Arguments]    ${initial_total}    ${removed_product_price}    ${expected_difference}
    ${updated_total}=    Get Summary Total
    ${difference}=    Evaluate    ${initial_total} - ${updated_total}
    Log    Initial total: ${initial_total}, Updated total: ${updated_total}, Difference: ${difference}
    Should Not Be Equal As Numbers    ${updated_total}    ${initial_total}
