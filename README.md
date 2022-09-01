# CurrencyApi

Currency API is a light wrapper for [currencylayer.com](https://currencylayer.com/) for Rubyists.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add currency_api

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install currency_api

## Usage

### API Documentation

The API documentation can be found [here](https://currencylayer.com/documentation).

### Get Account Information

Create an account on [currencylayer.com](https://currencylayer.com/) and get your API access key.
Save the access key in an environment variable named `CURRENCY_LAYER_ACCESS_KEY`.

### Configure

Currency Layer does not allow you ssl endpoint unless you have a paid account. By default ssl is enabled. To disable ssl, set the `ssl` option to `false`.

```ruby
require 'currency_api'
client = CurrencyApi::Client.new(access_key: ENV['CURRENCY_LAYER_ACCESS_KEY'], ssl: true)
```
params:
- `access_key` - Required - String - Your API access key.
- `ssl` - Optional - Boolean - Enable or disable ssl. Default is `true`.

response:
```bash
#<CurrencyApi::Client:0x00007f9b0a0b0a00 @access_key="YOUR_ACCESS_KEY", @ssl=true>
```

### Get List of currencies

```ruby
client.list
```

response:

```bash
[
  #<CurrencyApi::Currency:0x00007f9b0a0b0a00 @code="AED", @name="United Arab Emirates Dirham">,
  #<CurrencyApi::Currency:0x00007f9b0a0b09c0 @code="AFN", @name="Afghan Afghani">,
  ...
]
```

### Get Live Exchange Rates

```ruby
client.live(from: "USD", to: ["AED", "EUR"])
```
params:
- `from` Required - String - The currency you want to convert from. (default: USD)
- `to`  Optional - Array[String] - The currencies you want to convert to. (default: nil)

response:

```bash
[
  #<CurrencyApi::Conversion:0x00007f9b0a0b0a00 @from_code="USD", @to_code="AED", @value=3.6725, @date="2019-01-01">,
  #<CurrencyApi::Conversion:0x00007f9b0a0b09c0 @from_code="USD", @to_code="EUR", @value=0.888, @date="2019-01-01">,
]
```

### Get Historical Exchange Rates

```ruby
client.historical(from: "USD", to: ["AED", "EUR"], date: "2019-01-01")
```
params:
- `from` Required - String - The currency you want to convert from. (default: USD)
- `to`  Optional - Array[String] - The currencies you want to convert to. (default: nil)
- `date` Required - String 'YYYY-MM-DD' - The date you want to get the exchange rates for. (default: nil)

response:

```bash
[
  #<CurrencyApi::Conversion:0x00007f9b0a0b0a00 @from_code="USD", @to_code="AED", @value=3.6725, @date="2019-01-01">,
  #<CurrencyApi::Conversion:0x00007f9b0a0b09c0 @from_code="USD", @to_code="EUR", @value=0.888, @date="2019-01-01">,
]
```

### Get Conversion Rate given amount

```ruby
client.convert(from: "USD", to: "AED", amount: 100)
```

params:
- `from` Required - String - The currency you want to convert from. (default: USD)
- `to`  Required - String - The currency you want to convert to. (default: nil)
- `amount` Required - Int - The amount you want to convert. (default: nil)
- `date` Optional - String 'YYYY-MM-DD' - The date you want to get the exchange rates for. (default: nil)

response:

```bash
367.25
```

### Error Handling

```ruby
begin
  client.live(from: "USD", to: ["AED", "EUR"])
rescue CurrencyApi::Error => e
    puts e.code
    puts e.message
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/currency_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/currency_api/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CurrencyApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/currency_api/blob/main/CODE_OF_CONDUCT.md).
