# CoinPayments.net API Client
[![Gem Version](https://badge.fury.io/rb/coinpayments.svg)](https://badge.fury.io/rb/coinpayments) [![Build Status](https://travis-ci.org/Salet/coinpayments.svg?branch=master)](https://travis-ci.org/Salet/coinpayments) [![Code Climate](https://codeclimate.com/github/Salet/coinpayments/badges/gpa.svg)](https://codeclimate.com/github/Salet/coinpayments)

[CoinPayments](https://www.coinpayments.net) | [API Documentation](https://www.coinpayments.net/merchant-tools-api) | [Usage](#usage)

CoinPayments.net is a payment gateway that can allow you to accept Bitcoin, Litecoin, Ether and over [50 other popular cryptocurrencies](https://www.coinpayments.net/supported-coins) directly on your website. 

This gem will let you to easily communicate with their API directly from your Ruby application. Want to accept Doge, Dash, START, or other less popular cryptocurrency? Search no more!

## Installation

Add this line to your application's Gemfile:

    gem 'coinpayments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coinpayments

## Configuration

Before using this gem you will have to create an account on Coinpayments website. After that you can access your [Merchant ID](https://www.coinpayments.net/acct-settings) and generate [public/private API key pair](https://www.coinpayments.net/acct-api-keys) needed for this gem to work.

If you are using Rails, simply generate a new config file, like so:

    $ rails generate coinpayments:install

Configuration file can now be accessed at `config/initializers/coinpayments.rb`:

```
Coinpayments.configure do |config|
  config.merchant_id     = ''
  config.public_api_key  = ''
  config.private_api_key = ''
  config.secret_phrase   = ''
end
```

## Usage
`Coinpayments` is a singleton class with method names mimicking the command names of [CP API](https://www.coinpayments.net/merchant-tools-api). 

Common required fields are automatically appended to each call. Other of the required parameters must be passed in as method attributes. You can add some optional parameters too. 

For your convenience response fields can be accessed as method calls.

For example, to quickly access current BTC/USD exchange rate, use:

`Coinpayments.rates.USD.rate_btc`

## Examples

- Check current exchange rates:

`Coinpayments.rates`

- Check for cryptocurrencies you accept on  your account:

`Coinpayments.rates(accepted: 1).delete_if { |_k, v| v["accepted"] == 0 }.keys`

- Create a transaction for $10 that must be payed using BTC, and display an address to the user:

```
transaction = Coinpayments.create_transaction(10, 'USD', 'BTC')
@address = transaction.address
```
- You can recieve IPN callbacks after payments on API-generated addresses.
Coinpayments server generates signature based on your secret phrase and row 
body of POST request to your custom API. You can easily compare signatures
to verify callback using 
```
Coinpayments.sign('IPN POST request row body')
```

## Contributing

1. Fork it ( https://github.com/Salet/coinpayments/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
