# BTC Markets Ruby Gem
[![Gem Version](https://badge.fury.io/rb/nl-btcmarkets.svg)](https://badge.fury.io/rb/nl-btcmarkets)

## About / Why
Decided its time to create a ruby interface for the BTCMarkets.net API.

Currently it only supports querying data. API may change if we support trading.

## Building

```bash
# Assuming you are installing 0.0.1
gem build nl-btcmarkets.gemspec
gem install nl-btcmarkets-0.0.1.gem
```

## installing
```bash
gem install nl-btcmarkets
```

### Or add the following to your Gemfile
```text
source 'https://rubygems.org'

gem 'httparty'
gem 'nl-btcmarkets'
```

## Usage
### Environment Variables
The following environment variables need to be set up
* btcm_access_key
* btcm_access_secret

### Sample Code
```ruby
require 'nl-btcmarkets'

b = BTCMarkets.new
puts b.market_BTC_AUD_tick # Get the spot quote
puts b.market_BTC_AUD_orderbook # Get orderbook
puts b.account_balance # Get account balance
```

#### Get Account Balance if not 0
```ruby
require 'nl-btcmarkets'
require 'json'
b = BTCMarkets.new
JSON.parse(b.account_balance).each{|bal|
  if bal['balance'] > 0 then
    if bal['currency'] == 'AUD' or bal['currency'] == 'USD'
      puts "Balance: #{bal['currency']}$#{(bal['balance'].to_f / 100000000).to_s} / Trading Balance: #{bal['currency']}$#{(bal['pendingFunds'].to_f / 100000000).to_s}"
    end
  end
}
```

## Disclaimer
* This is an early stage pre-release. Use at your own risk.
* Pull Requests are appreciated
