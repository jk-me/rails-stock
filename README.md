# MockPortfolio

A mock stock portfolio app. User can purchase stocks and manage their portfolio and balance. Made with Rails 5 and the AlphaVantage API.

Note: The AlphaVantage API allows up to 5 requests per minute per apikey. This app will automatically update all stock prices at 60 sec intervals (1 request per stock). This interval can be stopped by clicking 'Stop Updating' each time the Portfolio page loads.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

This app is built on the ruby gems listed in the Gemfile, including ruby 2.5.1 and rails 5.2.1

### Installing

To deploy the app locally, run the following commands in your terminal after navigating to the root directory of this repository. You may opt to seed the database with sample data using $rake db:seed

```
$bundle install
$rake db:migrate
$rake db:seed
$rails s
```

Then navigate to localhost:3000 in your web browser.

## Author

* **Jenny Kam**
 [jk-me](https://github.com/jk-me)

