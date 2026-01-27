*** Comments ***
# Common Keywords
# This file contains common/shared keywords used across multiple test suites.

*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource     ../locators/login_locators.resource

*** Variables ***
${DEFAULT_TIMEOUT}    10

*** Keywords ***
Open Browser And Maximize
    [Documentation]    Opens Chrome browser with incognito mode and optimized settings.
    ...                Disables password manager popups and automation detection.
    [Arguments]    ${url}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --incognito
    Call Method    ${chrome_options}    add_argument    --disable-save-password-bubble
    Call Method    ${chrome_options}    add_argument    --disable-infobars
    Call Method    ${chrome_options}    add_argument    --disable-notifications
    Call Method    ${chrome_options}    add_argument    --disable-popup-blocking
    ${prefs}=    Create Dictionary
    ...    credentials_enable_service=${False}
    ...    profile.password_manager_enabled=${False}
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    ${exclude_switches}=    Create List    enable-automation
    Call Method    ${chrome_options}    add_experimental_option    excludeSwitches    ${exclude_switches}
    Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${url}
    Maximize Browser Window
    Sleep    2s

Dismiss Browser Popups
    [Documentation]    Dismisses any browser popups by pressing Escape key.
    Press Keys    None    ESCAPE
    Sleep    1s

Wait For Element And Click
    [Documentation]    Waits for element to be visible and clicks it.
    [Arguments]    ${locator}    ${timeout}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Click Element    ${locator}

Wait For Element And Input Text
    [Documentation]    Waits for element to be visible and inputs text.
    [Arguments]    ${locator}    ${text}    ${timeout}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Input Text    ${locator}    ${text}

Get Element Text Safely
    [Documentation]    Gets text from element with wait for visibility.
    [Arguments]    ${locator}    ${timeout}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    ${text}=    Get Text    ${locator}
    RETURN    ${text}

Extract Price Value
    [Documentation]    Extracts numeric price value from price string (removes $ and converts to number).
    [Arguments]    ${price_text}
    ${price_value}=    Convert To Number    ${price_text.replace('$', '')}
    RETURN    ${price_value}

Extract Total Price Value
    [Documentation]    Extracts numeric value from total price text (removes non-numeric characters except decimal).
    [Arguments]    ${total_text}
    ${price_convert}=    Evaluate    ''.join(c for c in '''${total_text}''' if c.isdigit() or c == '.')
    ${price_value}=    Convert To Number    ${price_convert}
    RETURN    ${price_value}
