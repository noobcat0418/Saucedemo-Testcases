*** Settings ***
Library           SeleniumLibrary
Suite Setup    Open Browser and Maximize
Suite Teardown    Close Browser

*** Variables ***
#Testdata
${URL}         https://www.saucedemo.com/v1/
${USERNAME}    standard_user
${PASSWORD}    secret_sauce
${PRODUCT_1}    Sauce Labs Backpack
${PRODUCT_2}    Sauce Labs Bike Light
${PRODUCT_3}    Sauce Labs Bolt T-Shirt
${TD_FIRST_NAME}    Juan
${TD_LAST_NAME}    Cruz
${TD_POSTAL_CODE}    1234

#Web Elements
${CART_ICON}      xpath=//div[contains(@id, 'shopping_cart_container')]
${REMOVE_BUTTON}  xpath=//button[contains(text(), 'Remove')]
${PRODUCT_LIST}   xpath=//div[contains(@class, 'cart_list')]/div[contains(@class, 'cart_item')]
${CONTINUE_SHOPPING_BUTTON}    xpath=//div[contains(@class, 'cart_footer')]/a[contains(normalize-space(), 'Continue Shopping')]
${CHECKOUT_BUTTON}    xpath=//div[contains(@class, 'cart_footer')]/child::a[contains(normalize-space(), 'CHECKOUT')]
${CANCEL_BUTTON}    xpath=//div[contains(@class, 'cart_footer')]/child::a[contains(normalize-space(), 'CANCEL')]
${FIRST_NAME}    xpath=//input[@id='first-name']
${LAST_NAME}    xpath=//input[@id='last-name']
${POSTAL_CODE}    xpath=//input[@id='postal-code']
${CONTINUE_BUTTON}    xpath=//input[contains(@class, 'btn_primary cart_button')]
${TAX_LABEL}    xpath=//div[contains(@class, 'summary_tax_label')]
${TOTAL_PRICE}    xpath=//div[contains(@class, 'summary_total_label')]

*** Test Cases ***
Manage Shopping Cart
    [Documentation]    Verify that users can manage their shopping cart.

    Login To Application
    Add Product To Cart    ${PRODUCT_1}  ${PRODUCT_2}
    ${product1_price}    ${product2_price}=    Save product price on inventory page    ${PRODUCT_1}    ${PRODUCT_2}
    Verify Cart Icon Functionality
    Verify Cart Displays Correct Products    ${PRODUCT_1_PRICE}    ${PRODUCT_2_PRICE}
    Remove Product From Cart    ${PRODUCT_1}
    Populate Check out: Your Information
    Verify Total Price Updates when a product is removed
    #Verify Total Price Updates when a product is added

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

Add Product To Cart
    [Documentation]    Add two products to the cart
    [Arguments]    ${PRODUCT_1}    ${PRODUCT_2}

    Wait Until Element Is Visible    xpath=//div[contains(text(),'${PRODUCT_1}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div/button      10
    Click Element     xpath=//div[contains(text(),'${PRODUCT_1}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div/button
    Click Element     xpath=//div[contains(text(),'${PRODUCT_2}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div/button

Save product price on inventory page
    [Documentation]    Save product price from inventory page
    [Arguments]    ${PRODUCT_1_PRICE}    ${PRODUCT_2_PRICE}

    #Get products price from inventory page and convert to number
    ${product1_price_text}=    Get Text    xpath=//div[contains(text(),'${PRODUCT_1}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div[contains(@class, 'pricebar')]/div[contains(@class, 'inventory_item_price')]
    ${product1_price}=    Convert To Number    ${product1_price_text.replace('$', '')}
    ${product2_price_text}=    Get Text    xpath=//div[contains(text(),'${PRODUCT_2}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div[contains(@class, 'pricebar')]/div[contains(@class, 'inventory_item_price')]
    ${product2_price}=    Convert To Number    ${product2_price_text.replace('$', '')}
    Log    get product price: ${product1_price}
    Log    get product price: ${product2_price}
    RETURN    ${product1_price}    ${product2_price}

Verify Cart Icon Functionality
    [Documentation]    Verify cart icon works properly
    Click Element    ${CART_ICON}
    Page Should Contain Element    ${PRODUCT_LIST}

Verify Cart Displays Correct Products
    [Documentation]    Verify cart cart display products
    [Arguments]    ${PRODUCT_1_PRICE}    ${PRODUCT_2_PRICE}
    ${products}=    Get WebElements    ${PRODUCT_LIST}  #List of product elements
    ${product_count}=    Get Length    ${products}  #Count of products
    Should Be Equal As Integers    ${product_count}    2  # Compare static number of added products

    #Verify product names added on cart
    ${cart_product1}=    Get Text    xpath=//div[contains(@class, 'inventory_item_name') and text()='${PRODUCT_1}']
    ${cart_product2}=    Get Text    xpath=//div[contains(@class, 'inventory_item_name') and text()='${PRODUCT_2}']
    Should Be Equal    ${cart_product1}    ${PRODUCT_1}
    Should Be Equal    ${cart_product2}    ${PRODUCT_2}

    #Verify quantities added on cart
    ${quantity_product1}=    Get Text    xpath=//div[contains(text(), '${PRODUCT_1}')]/preceding::div[contains(@class, 'cart_quantity')][1]
    ${quantity_product2}=    Get Text    xpath=//div[contains(text(), '${PRODUCT_2}')]/preceding::div[contains(@class, 'cart_quantity')][1]
    Should Be Equal    ${quantity_product1}    1
    Should Be Equal    ${quantity_product2}    1
    
    #Verify Total Price added on cart
    ${cart_product1_price_text}    Get Text    xpath=//div[contains(text(), '${PRODUCT_1}')]/following::div[contains(@class, 'inventory_item_price')][1]
    ${cart_product1_price}=    Convert To Number    ${cart_product1_price_text.replace('$', '')}
    
    ${cart_product2_price_text}    Get Text    xpath=//div[contains(text(), '${PRODUCT_2}')]/following::div[contains(@class, 'inventory_item_price')][1]
    ${cart_product2_price}=    Convert To Number    ${cart_product2_price_text.replace('$', '')}

    Should Be Equal As Numbers    ${product1_price}     ${cart_product1_price}
    Should Be Equal As Numbers    ${product2_price}     ${cart_product2_price}

Remove Product From Cart
    [Documentation]    Remove one product on cart
    [Arguments]    ${PRODUCT_1}
    Click Element    xpath=//div[contains(text(), '${PRODUCT_1}')]/ancestor::div[contains(@class, 'cart_item_label')]//button[contains(@class, 'btn_secondary cart_button')]    # Remove one product
    Wait Until Element Is Not Visible    //div[contains(text(), '${PRODUCT_1}')]/ancestor::div[contains(@class, 'cart_item_label')]//button[contains(@class, 'btn_secondary cart_button')]    10    # Wait for the first product to be removed
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON}    10
    Click Link    ${CHECKOUT_BUTTON}

Populate Check out: Your Information
    [Documentation]    Populate Check Out: Your Information page
    Wait Until Element Is Visible    ${FIRST_NAME}    5
    Input Text    ${FIRST_NAME}    ${TD_FIRST_NAME}
    Input Text    ${LAST_NAME}    ${TD_LAST_NAME}    
    Input Text    ${POSTAL_CODE}    ${TD_POSTAL_CODE}
    Click Button    ${CONTINUE_BUTTON}

Verify Total Price Updates when a product is removed
    [Documentation]    Verify total price is updated when a product is removed

    Wait Until Element Is Visible    ${CANCEL_BUTTON}
    Click Link    ${CANCEL_BUTTON}    #Clink cancel to go to inventory page

    Wait Until Element Is Visible    xpath=//div[contains(text(),'${PRODUCT_1}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div/button      10    #Wait for product to display
    Click Element     xpath=//div[contains(text(),'${PRODUCT_1}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div/button    #Add another product
    Click Element     xpath=//div[contains(text(),'${PRODUCT_3}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div/button    #Add another product

    #Get products price from add to cart page and convert to number
    ${product1_price_text}=    Get Text    xpath=//div[contains(text(),'${PRODUCT_1}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div[contains(@class, 'pricebar')]/div[contains(@class, 'inventory_item_price')]
    ${product1_price_value}=    Convert To Number    ${product1_price_text.replace('$', '')}
    ${product3_price_text}=    Get Text    xpath=//div[contains(text(),'${PRODUCT_3}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div[contains(@class, 'pricebar')]/div[contains(@class, 'inventory_item_price')]
    ${product3_price_value}=    Convert To Number    ${product3_price_text.replace('$', '')}
    Log    get product price: ${product1_price_value}
    Log    get product price: ${product3_price_value}

    #Proceed to checkout page
    Click Element    ${CART_ICON}
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON}    10
    Click Element    ${CHECKOUT_BUTTON}

    #Repopulate Check out: Your information page
    Populate Check out: Your Information

    #Get initial total price and convert to number
    Wait Until Element Is Visible    ${TOTAL_PRICE}    5
    ${total_price_text}=    Get Text    ${TOTAL_PRICE}
    ${initial_total_price_convert}=    Evaluate    ''.join(c for c in '''${total_price_text}''' if c.isdigit() or c == '.')
    ${initial_total_price_value}=    Convert To Number    ${initial_total_price_convert}
    log    initial total price: ${initial_total_price_value}

    #Get tax of first product and convert to number
    ${tax_first_product_text}=    Get Text    ${TAX_LABEL}
    ${tax_first_product_convert}=    Evaluate    ''.join(c for c in '''${tax_first_product_text}''' if c.isdigit() or c == '.')
    ${tax_first_product_value}=    Convert To Number    ${tax_first_product_convert}
    log    first product tax: ${tax_first_product_value}

    Wait Until Element Is Visible    ${CANCEL_BUTTON} 
    Click Link    ${CANCEL_BUTTON}    #Clink cancel to go to inventory page
    Verify Cart Icon Functionality    #Clink cart icon
    Click Button    xpath=//div[contains(text(), '${PRODUCT_1}')]/ancestor::div[contains(@class, 'cart_item_label')]/div/button    #Remove product 1
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON}    10
    Click Element    ${CHECKOUT_BUTTON}    #Proceed to checkout products

    #Repopulate Check out: Your information page
    Populate Check out: Your Information

    #Get updated total price remove the 'total:' and convert to number
    Wait Until Element Is Visible    ${TOTAL_PRICE}    5
    ${updated_total_price_text}=    Get Text    ${TOTAL_PRICE}
    ${updated_total_price_convert}=    Evaluate    ''.join(c for c in '''${updated_total_price_text}''' if c.isdigit() or c == '.')
    ${updated_total_price_value}=    Convert To Number    ${updated_total_price_convert}
    log    updated total price: ${updated_total_price_value}

    #Get tax of second product
    ${tax_second_product_text}=    Get Text    ${TAX_LABEL}
    ${tax_second_product_convert}=    Evaluate    ''.join(c for c in '''${tax_second_product_text}''' if c.isdigit() or c == '.')
    ${tax_second_product_value}=    Convert To Number    ${tax_second_product_convert}
    ${all_tax_value}    Evaluate    abs(${tax_first_product_value} - ${tax_second_product_value})
    log    first product tax: ${tax_first_product_value}
    log    second product tax: ${tax_second_product_value}
    log    all product tax: ${all_tax_value}

    #Validate expected total price and updated total price not equal since 1 product is removed
    ${expected_total_price}=    Evaluate    ${initial_total_price_value} + ${product1_price_value}+ ${product3_price_value} + ${all_tax_value}
    Log    Initial total: ${initial_total_price_value}
    Log    product1 price: ${product1_price_value}
    Log    product3 price: ${product3_price_value}
    Log    updated total price: ${updated_total_price_value}
    Log    expected total price: ${expected_total_price}
    Should Not Be Equal As Numbers     ${updated_total_price_value}    ${expected_total_price}

#This is an additional test scenario when you add a product and validate the total price. Commented for now
Verify Total Price Updates when a product is added
    [Documentation]    Verify total price is updated when a product is added

    #Get initial total price and convert to number
    Wait Until Element Is Visible    ${TOTAL_PRICE}    5
    ${total_price_text}=    Get Text    ${TOTAL_PRICE}
    ${initial_total_price_convert}=    Evaluate    ''.join(c for c in '''${total_price_text}''' if c.isdigit() or c == '.')
    ${initial_total_price_value}=    Convert To Number    ${initial_total_price_convert}
    log    initial total price: ${initial_total_price_value}
    
    #Get tax of first product and convert to number
    ${tax_first_product_text}=    Get Text    ${TAX_LABEL}    
    ${tax_first_product_convert}=    Evaluate    ''.join(c for c in '''${tax_first_product_text}''' if c.isdigit() or c == '.')
    ${tax_first_product_value}=    Convert To Number    ${tax_first_product_convert}
    log    first product tax: ${tax_first_product_value}
    
    Wait Until Element Is Visible    ${CANCEL_BUTTON}
    Click Link    ${CANCEL_BUTTON}    #Clink cancel to go to inventory page
    
    Wait Until Element Is Visible    xpath=//div[contains(text(),'${PRODUCT_1}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div/button      10    #Wait for product to display
    Click Element     xpath=//div[contains(text(),'${PRODUCT_1}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div/button    #Add another product

    #Get product price and convert to number
    ${product_price_text}=    Get Text    xpath=//div[contains(text(),'${PRODUCT_1}')]/ancestor::div[@class='inventory_item_label']/following-sibling::div[contains(@class, 'pricebar')]/div[contains(@class, 'inventory_item_price')]
    ${product_price}=    Convert To Number    ${product_price_text.replace('$', '')}
    Log    get product price: ${product_price}
    
    #Proceed to checkout page
    Click Element    ${CART_ICON}
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON}    10
    Click Element    ${CHECKOUT_BUTTON}

    #Repopulate Check out: Your information page
    Populate Check out: Your Information

    #Get updated total price remove the 'total:' and convert to number
    Wait Until Element Is Visible    ${TOTAL_PRICE}    5
    ${updated_total_price_text}=    Get Text    ${TOTAL_PRICE}
    ${updated_total_price_convert}=    Evaluate    ''.join(c for c in '''${updated_total_price_text}''' if c.isdigit() or c == '.')
    ${updated_total_price_value}=    Convert To Number    ${updated_total_price_convert}
    log    updated total price: ${updated_total_price_value}

    #Get tax of second product
    ${tax_second_product_text}=    Get Text    ${TAX_LABEL}
    ${tax_second_product_convert}=    Evaluate    ''.join(c for c in '''${tax_second_product_text}''' if c.isdigit() or c == '.')
    ${tax_second_product_value}=    Convert To Number    ${tax_second_product_convert}
    ${all_tax_value}    Evaluate    abs(${tax_first_product_value} - ${tax_second_product_value})
    log    first product tax: ${tax_first_product_value}
    log    second product tax: ${tax_second_product_value}
    log    all product tax: ${all_tax_value}
    
    #Validate expected total price and updated total price
    ${expected_total_price}=    Evaluate    ${initial_total_price_value} + ${product_price} + ${all_tax_value}
    Log    Initial total: ${initial_total_price_value}
    Log    product price: ${product_price}
    Log    updated total price: ${updated_total_price_value}
    Log    expected total price: ${expected_total_price}
    Should Be Equal As Numbers    ${updated_total_price_value}    ${expected_total_price}