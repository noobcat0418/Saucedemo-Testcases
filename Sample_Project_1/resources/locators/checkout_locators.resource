*** Comments ***
# Checkout Page Locators
# This file contains all locators for the checkout pages of Saucedemo application.

*** Variables ***
# Checkout Information Form
${CHECKOUT_FIRST_NAME_INPUT}         id:first-name
${CHECKOUT_LAST_NAME_INPUT}          id:last-name
${CHECKOUT_POSTAL_CODE_INPUT}        id:postal-code
${CHECKOUT_CONTINUE_BTN}             id:continue
${CHECKOUT_CANCEL_BTN}               id:cancel
${CHECKOUT_ERROR_MESSAGE}            css:[data-test="error"]

# Checkout Overview Page
${SUMMARY_SUBTOTAL}                  css:.summary_subtotal_label
${SUMMARY_TAX}                       css:.summary_tax_label
${SUMMARY_TOTAL}                     css:.summary_total_label
${FINISH_BTN}                        id:finish

# Checkout Complete Page
${CHECKOUT_COMPLETE_HEADER}          css:.complete-header
${CHECKOUT_COMPLETE_TEXT}            css:.complete-text
${BACK_HOME_BTN}                     id:back-to-products
