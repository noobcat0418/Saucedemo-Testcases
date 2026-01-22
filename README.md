# Robotframework saucedemo Test Automation Suite

Automated test suite for [Saucedemo](https://www.saucedemo.com/) - a sample e-commerce web application by Sauce Labs. This project demonstrates end-to-end test automation using **Robot Framework** with **Python** and **SeleniumLibrary**.

![Robot Framework](https://img.shields.io/badge/Robot%20Framework-000000?style=flat&logo=robot-framework&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Selenium](https://img.shields.io/badge/Selenium-43B02A?style=flat&logo=selenium&logoColor=white)

---

## Table of Contents

- [About the Project](#about-the-project)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Running Tests](#running-tests)
- [Test Scenarios](#test-scenarios)
- [Reports](#reports)
- [Contributing](#contributing)
- [Author](#author)

---

## About the Project

This repository contains automated test cases for the Saucedemo web application, covering critical e-commerce functionalities including:

- User Authentication (login/logout)
- Product Catalog browsing and sorting
- Shopping Cart operations
- Checkout workflow
- Form validations and error handling

The project follows a **keyword-driven** approach with reusable keywords and resource files for maintainable test automation.

---

## Tech Stack

| Category | Technology |
|----------|------------|
| Language | Python 3.x |
| Framework | Robot Framework |
| Browser Automation | SeleniumLibrary |
| Browser | Chrome / Firefox |
| Reporting | Robot Framework HTML Reports |
| Version Control | Git |

---

## Project Structure

```
Saucedemo-Testcases/
├── tests/                       # Test suite files
│   ├── login_tests.robot
│   ├── product_tests.robot
│   ├── cart_tests.robot
│   └── checkout_tests.robot
├── resources/
│   ├── keywords/                # Custom keyword files
│   │   ├── login_keywords.robot
│   │   ├── product_keywords.robot
│   │   ├── cart_keywords.robot
│   │   └── checkout_keywords.robot
│   ├── locators/                # Element locators
│   │   └── locators.robot
│   └── common.robot             # Common keywords and setup
├── data/                        # Test data
│   └── test_data.robot
├── results/                     # Generated test reports
│   ├── log.html
│   ├── report.html
│   └── output.xml
├── requirements.txt             # Python dependencies
└── README.md
```

---

## Getting Started

### Prerequisites

- Python 3.8 or higher
- pip (Python package manager)
- Chrome or Firefox browser
- ChromeDriver or GeckoDriver
- Git

### Installation

1. **Clone the repository**
   ```bash
   # Downloads the project files from GitHub to your local machine
   git clone https://github.com/noobcat0418/Saucedemo-Testcases.git
   ```

2. **Navigate to project directory**
   ```bash
   # Changes your current directory to the project folder
   cd Saucedemo-Testcases
   ```

3. **Create virtual environment (recommended)**
   ```bash
   # Creates an isolated Python environment for this project
   python -m venv venv
   
   # Activates the virtual environment (Windows)
   venv\Scripts\activate
   
   # Activates the virtual environment (Mac/Linux)
   source venv/bin/activate
   ```

4. **Install dependencies**
   ```bash
   # Installs all required Python packages from requirements.txt
   pip install -r requirements.txt
   ```

### Requirements.txt
```
robotframework>=6.0
robotframework-seleniumlibrary>=6.0
webdrivermanager
```

---

## Running Tests

### Run all tests
```bash
# Executes all .robot test files in the tests directory
robot tests/
```

### Run specific test file
```bash
# Runs only the login test suite
robot tests/login_tests.robot
```

### Run tests by tag
```bash
# Runs only tests tagged as 'smoke'
robot --include smoke tests/

# Runs all tests except those tagged as 'wip' (work in progress)
robot --exclude wip tests/
```

### Run with custom output directory
```bash
# Saves all reports to the 'results' folder
robot --outputdir results tests/
```

### Run in headless mode
```bash
# Runs tests without opening a visible browser window
robot --variable BROWSER:headlesschrome tests/
```

### Run specific test case by name
```bash
# Executes only the test case matching the given name
robot --test "Valid Login With Standard User" tests/
```

---

## Test Scenarios

### Authentication Tests
| Test Case | Description | Tag |
|-----------|-------------|-----|
| Valid Login With Standard User | Login with valid credentials | smoke |
| Invalid Login With Wrong Password | Verify error message for wrong password | regression |
| Login With Locked Out User | Verify locked user cannot login | regression |
| Login With Empty Credentials | Verify validation for empty fields | regression |
| Successful Logout | Verify user can logout | smoke |

### Product Tests
| Test Case | Description | Tag |
|-----------|-------------|-----|
| Verify All Products Displayed | Check all 6 products are visible | smoke |
| Sort Products By Price Low To High | Verify price sorting ascending | regression |
| Sort Products By Price High To Low | Verify price sorting descending | regression |
| Sort Products By Name A To Z | Verify alphabetical sorting | regression |
| View Product Details | Click product and verify details page | smoke |

### Cart Tests
| Test Case | Description | Tag |
|-----------|-------------|-----|
| Add Single Item To Cart | Add one product to cart | smoke |
| Add Multiple Items To Cart | Add several products to cart | smoke |
| Remove Item From Cart | Remove product from cart | regression |
| Verify Cart Badge Count | Check cart icon shows correct count | regression |
| Continue Shopping From Cart | Return to products from cart | regression |

### Checkout Tests
| Test Case | Description | Tag |
|-----------|-------------|-----|
| Complete Checkout Successfully | Full checkout with valid info | smoke |
| Checkout With Missing First Name | Verify first name validation | regression |
| Checkout With Missing Last Name | Verify last name validation | regression |
| Checkout With Missing Postal Code | Verify postal code validation | regression |
| Verify Order Summary | Check item totals and tax | regression |
| Cancel Checkout | Verify cancel returns to cart | regression |

---

## Reports

Robot Framework automatically generates HTML reports after each test run.

### Default Report Location
After running tests, find reports in the project root or specified output directory:

| File | Description |
|------|-------------|
| `report.html` | High-level test summary with pass/fail statistics |
| `log.html` | Detailed step-by-step execution log |
| `output.xml` | Machine-readable output for CI/CD integration |

### Generate reports in custom directory
```bash
# Outputs all report files to the 'results' folder
robot --outputdir results tests/
```

### Open report after test run
```bash
# Windows - opens the HTML report in default browser
start results/report.html

# Mac
open results/report.html

# Linux
xdg-open results/report.html
```

---

## Sample Test Code

```robot
*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/common.robot
Resource    ../resources/keywords/login_keywords.robot

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers

*** Test Cases ***
Valid Login With Standard User
    [Tags]    smoke    login
    Enter Username    standard_user
    Enter Password    secret_sauce
    Click Login Button
    Verify Products Page Is Displayed

Invalid Login With Wrong Password
    [Tags]    regression    login
    Enter Username    standard_user
    Enter Password    wrong_password
    Click Login Button
    Verify Error Message    Epic sadface: Username and password do not match
```

---

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-test`)
3. Commit changes (`git commit -m 'Add new test case'`)
4. Push to branch (`git push origin feature/new-test`)
5. Open a Pull Request

---

## Author

**Mike Ryan Cervantes**  
Senior QA Automation Engineer

- GitHub: [@noobcat0418](https://github.com/noobcat0418)
- LinkedIn: [Mikeryan Cervantes](https://www.linkedin.com/in/mikeryan-cervantes)
- Email: cervantesmikeryan24@gmail.com

---

⭐ If you found this project helpful, please give it a star!
