# 🧪 SauceDemo Test Cases

Automated test suite for [SauceDemo](https://www.saucedemo.com/) - a sample e-commerce web application.

## 📋 Overview

This project contains automated test cases for the SauceDemo website, covering key functionalities such as user authentication, product browsing, cart management, and checkout processes.

## 🛠️ Tech Stack

- **Framework:** [Your Framework - e.g., Selenium, Cypress, Playwright]
- **Language:** [Your Language - e.g., Python, JavaScript, Java]
- **Test Runner:** [e.g., pytest, Jest, TestNG]
- **Reporting:** [e.g., Allure, HTML Reports]

## 📁 Project Structure

```
Saucedemo-Testcases/
├── tests/
│   ├── test_login.py
│   ├── test_inventory.py
│   ├── test_cart.py
│   └── test_checkout.py
├── pages/
│   ├── login_page.py
│   ├── inventory_page.py
│   ├── cart_page.py
│   └── checkout_page.py
├── utils/
│   └── config.py
├── requirements.txt
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- [Python 3.x / Node.js / Java] installed
- [Browser Driver - e.g., ChromeDriver] installed

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/noobcat0418/Saucedemo-Testcases.git
   cd Saucedemo-Testcases
   ```

2. Install dependencies:
   ```bash
   # For Python
   pip install -r requirements.txt
   
   # For Node.js
   npm install
   ```

### Running Tests

```bash
# Run all tests
pytest

# Run specific test file
pytest tests/test_login.py

# Run with verbose output
pytest -v
```

## ✅ Test Coverage

| Module | Test Cases | Status |
|--------|------------|--------|
| Login | Valid/Invalid credentials, Locked user | ✅ |
| Inventory | Product listing, Sorting, Add to cart | ✅ |
| Cart | Add/Remove items, Update quantity | ✅ |
| Checkout | Complete purchase flow | ✅ |

## 🔑 Test Credentials

SauceDemo provides the following test users:

| Username | Password | Description |
|----------|----------|-------------|
| `standard_user` | `secret_sauce` | Standard user |
| `locked_out_user` | `secret_sauce` | Locked out user |
| `problem_user` | `secret_sauce` | User with UI issues |
| `performance_glitch_user` | `secret_sauce` | Slow performance |

## 📊 Reports

Test reports are generated in the `reports/` directory after each test run.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-test`)
3. Commit your changes (`git commit -m 'Add new test case'`)
4. Push to the branch (`git push origin feature/new-test`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

- GitHub: [@noobcat0418](https://github.com/noobcat0418)
