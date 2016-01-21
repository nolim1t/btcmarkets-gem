# BTC Markets Ruby Gem
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

## Disclaimer
* This is an early stage pre-release. Use at your own risk.
* Pull Requests are appreciated
