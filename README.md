# BTC Markets Ruby Gem
## About / Why
Decided its time to create a ruby interface for the BTCMarkets.net API

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
### Sample Query of the order history
```ruby
require 'nl-btcmarkets'

b = BTCMarkets.new
puts b.market_BTC_AUD_tick
```

## Disclaimer
* This is an early stage pre-release. Use at your own risk.
* Pull Requests are appreciated
