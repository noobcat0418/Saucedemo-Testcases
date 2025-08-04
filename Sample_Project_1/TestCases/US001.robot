*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser and Maximize
Suite Teardown    Close Browser

*** Variables ***
${URL}         https://www.saucedemo.com/v1/
${USERNAME}    standard_user
${PASSWORD}    secret_sauce

*** Test Cases ***
View And Sort Products
    [Documentation]    Test to view and sort products on the inventory page
    Login To Application
    Verify Products Are Displayed
    Verify Add To Cart Functionality
    Verify Shopping Cart Updates
    Sort Products By Name A to Z
    Sort Products By Name Z to A
    Sort Products By Price Low to High
    Sort Products By Price High to Low

*** Keywords ***
Open Browser and Maximize
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Sleep    2  # Optional: only if page loading requires additional wait time

Login To Application
    [Documentation]    Log in to the application
    Input Text    xpath=//input[@id='user-name']    ${USERNAME}
    Input Text    xpath=//input[@id='password']    ${PASSWORD}
    Click Button    xpath=//input[@id='login-button']
    Wait Until Element Is Visible    xpath=//div[@class='inventory_item_name']    10  # Ensures inventory items are visible after login

Verify Products Are Displayed
    [Documentation]    Check if products details on inventory page are not empty.
    ${products}=    Get WebElements    xpath=//div[@class='inventory_item_name']
    Should Not Be Empty    ${products}    No products found on the inventory page.

    FOR    ${product}    IN    @{products}
        ${name}=    Get Text    ${product}
        Log    Product Name: ${name}
        Should Not Be Empty    ${name}    Product name is empty.

        ${description_element}=    Get WebElement    //div[contains(text(),'${name}')]/ancestor::div[@class='inventory_item_label']/div
        ${description}=    Get Text    ${description_element}
        Log    Product Description: ${description}
        Should Not Be Empty    ${description}    Product description is empty for ${name}.

        ${price_element}=    Get WebElement    //div[contains(text(),'${name}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div
        ${price}=    Get Text    ${price_element}
        Log    Product Price: ${price}
        Should Not Be Empty    ${price}    Product price is empty for ${name}.

        ${image_element}=    Get WebElement    //div[contains(text(),'${name}')]/preceding::div[@class='inventory_item_img']/a/img
        ${image_src}=    Get Element Attribute    ${image_element}    src
        Log    Product Image Source: ${image_src}
        Should Not Be Empty    ${image_src}    Product image source is empty for ${name}.
    END

Verify Add To Cart Functionality
    [Documentation]    Verify the functionality of adding products to the cart
    ${add_buttons}=    Get WebElements    xpath=//button[contains(@class, 'btn_inventory')]
    FOR    ${button}    IN    @{add_buttons}
        Click Button    ${button}
        Sleep    1  # Added a sleep time after clicking "Add to Cart"
    END

Verify Shopping Cart Updates
    [Documentation]    Check if the shopping cart icon updates correctly
    ${cart_icon}=    Get WebElement    xpath=//a[contains(@class, 'shopping_cart_link')]
    ${cart_text}=    Get Text    ${cart_icon}
    Should Be Equal As Strings    ${cart_text}    6    # Adjust based on the number of items you added - static for now

Sort Products By Name A to Z
    [Documentation]    Sort products by Name (A to Z)
    Select From List By Value    xpath=//select[@class='product_sort_container']    az
    Wait Until Element Is Visible    xpath=//div[@class='inventory_item_name']    10  # Waits for items to be visible after sorting

Sort Products By Name Z to A
    [Documentation]    Sort products by Name (Z to A)
    Select From List By Value    xpath=//select[@class='product_sort_container']    za
    Wait Until Element Is Visible    xpath=//div[@class='inventory_item_name']    10  # Waits for items to be visible after sorting

Sort Products By Price Low to High
    [Documentation]    Sort products by Price (low to high)
    Select From List By Value    xpath=//select[@class='product_sort_container']    lohi
    Wait Until Element Is Visible    xpath=//div[@class='inventory_item_name']    10  # Waits for items to be visible after sorting

Sort Products By Price High to Low
    [Documentation]    Sort products by Price (high to low)
    Select From List By Value    xpath=//select[@class='product_sort_container']    hilo
    Wait Until Element Is Visible    xpath=//div[@class='inventory_item_name']    10  # Waits for items to be visible after sorting
