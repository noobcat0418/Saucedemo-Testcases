*** Comments ***
# Login Keywords
# This file contains keywords related to login functionality.

*** Settings ***
Library     SeleniumLibrary
Resource    common_keywords.resource
Resource    ../locators/login_locators.resource
Resource    ../locators/inventory_locators.resource

*** Keywords ***
Login To Application
    [Documentation]    Logs in to the Saucedemo application with provided credentials.
    ...                Handles browser popups and waits for inventory page to load.
    [Arguments]    ${username}    ${password}
    Wait For Element And Input Text    ${LOGIN_USERNAME_INPUT}    ${username}
    Input Text    ${LOGIN_PASSWORD_INPUT}    ${password}
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s
    Dismiss Browser Popups
    Wait Until Element Is Visible    ${INVENTORY_ITEM_NAME}    ${DEFAULT_TIMEOUT}

Login With Valid Credentials
    [Documentation]    Logs in using the standard test user credentials.
    [Arguments]    ${username}    ${password}
    Login To Application    ${username}    ${password}

Verify Login Error Message
    [Documentation]    Verifies that an error message is displayed on failed login.
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${LOGIN_ERROR_MESSAGE}    ${DEFAULT_TIMEOUT}
    ${actual_message}=    Get Text    ${LOGIN_ERROR_MESSAGE}
    Should Contain    ${actual_message}    ${expected_message}
