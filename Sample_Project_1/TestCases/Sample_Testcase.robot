*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${_browser}  chrome
${_url}  https://www.saucedemo.com/v1/

*** Test Cases ***
Scenario 1:
    Open Browser    ${_url}  ${_browser}
    LoginToWebsite
    sleep   3
    # Define products directly in the test case to ensure correct interpretation
    @{PRODUCTS} =    Create List
    ...    {'name': 'Sauce Labs Backpack', 'description': 'A sleek backpack', 'price': 29.99, 'picture': 'sauce-backpack.jpg'}
    ...    {'name': 'Sauce Labs Bike Light', 'description': 'A bike light', 'price': 9.99, 'picture': 'bike-light.jpg'}
    ...    {'name': 'Sauce Labs Bolt T-Shirt', 'description': 'Get your superhero on!', 'price': 15.99, 'picture': 'bolt-shirt.jpg'}
    ...    {'name': 'Sauce Labs Fleece Jacket', 'description': 'Stay warm and stylish', 'price': 49.99, 'picture': 'fleece-jacket.jpg'}
    Validate Products   ${PRODUCTS}
    closeBrowser


*** Keywords ***
LoginToWebsite
    Input Text    id:user-name    standard_user
    Input Text    id:password    secret_sauce
    Click Button    xpath://input[@value='LOGIN']

Validate Products
    [Arguments]    @{products}
    Log Many    @{products}
    FOR    ${product}    IN    @{products}
       Log    Validating product: ${product['name']}
       Log    Type of product: ${product}  # Log the entire product dictionary
        Validate Product Details    ${product_id}    ${product['name']}    ${product['description']}    ${product['price']}    ${product['picture']}
    END

Validate Product Details
    [Arguments]    ${product_id}    ${expected_name}    ${expected_description}    ${expected_price}    ${expected_picture}

    # Fetch product details from the web page (replace xpaths with actual locators)
    ${actual_name}=         Get Text    xpath=//div[contains(@class, 'inventory_item_name')]
    ${actual_description}=  Get Text    xpath=//div[contains(@class, 'inventory_item_desc')]
    ${actual_price}=        Get Text    xpath=//div[contains(@class, 'inventory_item_price')]
    ${actual_picture}=      Get Element Attribute    xpath=//img[contains(@class, 'inventory_item_img')]    src

    # Log actual values for debugging
    Log    Actual Name: ${actual_name}
    Log    Actual Description: ${actual_description}
    Log    Actual Price: ${actual_price}
    Log    Actual Picture: ${actual_picture}

    # Validation steps
    Should Be Equal         ${actual_name}        ${expected_name}
    Should Be Equal         ${actual_description} ${expected_description}
    Should Be Equal As Numbers   ${actual_price}       ${expected_price}
    Should Be Equal         ${actual_picture}     ${expected_picture}
