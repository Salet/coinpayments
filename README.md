# CoinPayments.net API ruby gem

This is a convenient wrapper around CoinPayments.net API (https://www.coinpayments.net/merchant-tools-api).

## Installation

Add this line to your application's Gemfile:

    gem 'coinpayments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coinpayments

## Configuration

Before using this gem you have to set your Merchant ID and public/private API key pair, which can be accessed on your account at CoinPayments.net.

If you are using Rails, simply generate a new config file, like so:

    $ rails generate coinpayments:install

Configuration file can now be accessed at config/initializers/coinpayments.rb:

```
CoinPayments.configure do |config|
  config.merchant_id = ''
  config.public_api_key = ''
  config.private_api_key = ''
end
```

## Usage

- All method and field names are identical to official API documentation: https://www.coinpayments.net/merchant-tools-api.
- Main required fields are appended to each call you make automatically.
- Method required paramteres must be appended as method attributes.
- Optional paramteres can be appended as an option hash
- Call response is a Hashie::Mash instance, so you can access response hash parameters as method calls. For example, to quicly access BTC/USD exchange rate, use:

`CoinPayments.rates.USD.rate_btc`

## Examples

- Check current exchange rates:

`CoinPayments.rates`

- Check for cryptocurrencies you accept on  your account:

`CoinPayments.rates(accepted: 1).delete_if {|k, v| v["accepted"] == 0}.keys`

- Create a transaction for $10 that must be payed using BTC, and display an address to the user:

```
transaction = CoinPayments.create_transaction(10, 'USD', 'BTC')
@address = transaction.address
```

## Contributing

1. Fork it ( https://github.com/Salet/coinpayments/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
