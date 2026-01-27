*** Comments ***
# Sample Test Case
# Basic test to verify login and products display functionality.

*** Settings ***
Documentation    Sample test case for verifying basic login and product display functionality.

Library          SeleniumLibrary
Library          Collections

Resource         ../resources/keywords/common_keywords.resource
Resource         ../resources/keywords/login_keywords.resource
Resource         ../resources/keywords/inventory_keywords.resource

Resource         ../data/test_data.resource

Test Teardown    Close Browser

*** Test Cases ***
Scenario 1: Login And Verify Products Displayed
    [Documentation]    Verifies that a user can login successfully and products are displayed.
    [Tags]    smoke    login    products

    Open Browser And Maximize    ${BASE_URL}
    Login To Application    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Products Are Displayed
