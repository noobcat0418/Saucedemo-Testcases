*** Comments ***
# Inventory Page Locators
# This file contains all locators for the inventory/products page of Saucedemo application.

*** Variables ***
# Inventory Page Elements
${INVENTORY_ITEM}                    css:.inventory_item
${INVENTORY_ITEM_NAME}               css:.inventory_item_name
${INVENTORY_ITEM_DESC}               css:.inventory_item_desc
${INVENTORY_ITEM_PRICE}              css:.inventory_item_price
${INVENTORY_ITEM_IMAGE}              css:.inventory_item img
${PRODUCT_SORT_CONTAINER}            css:.product_sort_container

# Add To Cart Buttons (data-test selectors)
${ADD_BACKPACK_BTN}                  css:[data-test="add-to-cart-sauce-labs-backpack"]
${ADD_BIKE_LIGHT_BTN}                css:[data-test="add-to-cart-sauce-labs-bike-light"]
${ADD_BOLT_TSHIRT_BTN}               css:[data-test="add-to-cart-sauce-labs-bolt-t-shirt"]
${ADD_FLEECE_JACKET_BTN}             css:[data-test="add-to-cart-sauce-labs-fleece-jacket"]
${ADD_ONESIE_BTN}                    css:[data-test="add-to-cart-sauce-labs-onesie"]
${ADD_RED_TSHIRT_BTN}                css:[data-test="add-to-cart-test.allthethings()-t-shirt-(red)"]

# Remove From Cart Buttons (data-test selectors)
${REMOVE_BACKPACK_BTN}               css:[data-test="remove-sauce-labs-backpack"]
${REMOVE_BIKE_LIGHT_BTN}             css:[data-test="remove-sauce-labs-bike-light"]
${REMOVE_BOLT_TSHIRT_BTN}            css:[data-test="remove-sauce-labs-bolt-t-shirt"]
${REMOVE_FLEECE_JACKET_BTN}          css:[data-test="remove-sauce-labs-fleece-jacket"]
${REMOVE_ONESIE_BTN}                 css:[data-test="remove-sauce-labs-onesie"]
${REMOVE_RED_TSHIRT_BTN}             css:[data-test="remove-test.allthethings()-t-shirt-(red)"]

# General Remove Button Pattern
${REMOVE_BUTTON_PATTERN}             css:button[data-test^="remove"]

# Sort Options Values
${SORT_NAME_AZ}                      az
${SORT_NAME_ZA}                      za
${SORT_PRICE_LOW_HIGH}               lohi
${SORT_PRICE_HIGH_LOW}               hilo
