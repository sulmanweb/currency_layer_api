# frozen_string_literal: true

# rubocop:disable Layout/LineLength
module CurrencyApi
  # Client having API methods and access_keys
  class Client
    BASE_URL = "api.currencylayer.com/"

    attr_reader :access_key, :adapter

    # #### params:
    # access_key: String (Required)
    # ssl: Boolean (Optional) (Default: true)
    # adapter: Symbol (Optional) (Default: :net_http)
    # stubs: Faraday::Adapter::Test::Stubs (Optional) (Default: nil)
    # #### Example:
    # CurrencyApi::Client.new(access_key: "fake", ssl: false, adapter: :test, stubs: stub)
    # CurrencyApi::Client.new(access_key: "fake")
    # #### Description:
    # Creates a new instance of CurrencyApi::Client with access_key provided by currencylayer.com
    def initialize(access_key:, ssl: true, adapter: Faraday.default_adapter, stubs: nil)
      @access_key = access_key
      @adapter = adapter
      @ssl = ssl

      # Test stubs for requests
      @stubs = stubs
    end

    # #### Example:
    # CurrencyApi::Client.new(access_key: "fake").list
    # #### Response:
    # [
    #   #<CurrencyApi::Currency:0x00007f9b0a0b0a00 @code="AED", @name="United Arab Emirates Dirham">,
    #   #<CurrencyApi::Currency:0x00007f9b0a0b09c0 @code="AFN", @name="Afghan Afghani">,
    # ]
    # #### Description:
    # Resturns currency object array for all currencies available in currency layer
    def list
      get("list").body["currencies"].map { |key, val| Currency.new(code: key, name: val) }
    end

    # #### Params:
    # from: String (Required) (Default: "USD")
    # to: Array (Optional) (Default: nil)
    # #### Example:
    # CurrencyApi::Client.new(access_key: "fake").live(from: "USD", to: ["AED", "EUR"])
    # CurrencyApi::Client.new(access_key: "fake").live(from: "EUR")
    # #### Response:
    # [
    #   #<CurrencyApi::Conversion:0x00007f9b0a0b0a00 @from_code="USD", @to_code="AED", @value=3.6725, @date="2019-01-01">,
    #   #<CurrencyApi::Conversion:0x00007f9b0a0b09c0 @from_code="USD", @to_code="EUR", @value=0.888, @date="2019-01-01">,
    # ]
    # #### Description:
    # Returns the current exchange rate for a given from currency and to currencies
    def live(from: "USD", to: nil)
      get("live", { source: from, currencies: to ? to.join(",") : nil }.compact).body["quotes"].map do |key, val|
        Conversion.new(from_code: key[0..2], to_code: key[3..], value: val, date: Date.today.to_s)
      end
    end

    # #### Params:
    # date: String (Required) ('YYYY-MM-DD')
    # from: String (Required) (Default: "USD")
    # to: Array (Optional) (Default: nil)
    # #### Example:
    # CurrencyApi::Client.new(access_key: "fake").historical(date: "2019-01-01", from: "USD", to: ["AED", "EUR"])
    # CurrencyApi::Client.new(access_key: "fake").historical(date: "2019-01-01", from: "EUR")
    # #### Response:
    # [
    #   #<CurrencyApi::Conversion:0x00007f9b0a0b0a00 @from_code="USD", @to_code="AED", @value=3.6725, @date="2019-01-01">,
    #   #<CurrencyApi::Conversion:0x00007f9b0a0b09c0 @from_code="USD", @to_code="EUR", @value=0.888, @date="2019-01-01">,
    # ]
    # #### Description:
    # Returns the historical exchange rate for a given date, from currency and to currencies
    def historical(date:, from: "USD", to: nil)
      resp = get("historical", { date: date, source: from, currencies: to ? to.join(",") : nil }.compact)
      resp.body["quotes"].map do |key, val|
        Conversion.new(from_code: key[0..2], to_code: key[3..], value: val, date: resp.body["date"])
      end
    end

    # #### Params:
    # to: String (Required) (Currency code)
    # from: String (Required) (Currency code)
    # amount: Int (Required) (Default: 1)
    # date: String (Optional) ('YYYY-MM-DD')
    # #### Example:
    # CurrencyApi::Client.new(access_key: "fake").convert(to: "AED", from: "USD", amount: 1)
    # CurrencyApi::Client.new(access_key: "fake").convert(to: "AED", from: "USD", amount: 1, date: "2019-01-01")
    # #### Response:
    # 3.6725
    # #### Description:
    # Returns the exchange rate for a given date, from currency and to currency
    def convert(to:, from:, amount: 1, date: nil)
      get("convert", { from: from, to: to, amount: amount, date: date }.compact).body["result"]
    end

    private

    # creates a faraday connection with base url and access_key
    def connection
      @connection ||= Faraday.new("#{@ssl ? "https" : "http"}://#{BASE_URL}") do |conn|
        conn.params["access_key"] = access_key
        conn.request :json

        conn.response :json, content_type: "application/json"

        conn.adapter adapter, @stubs
      end
    end

    # makes a get request to the given path with params
    def get(path, params = {})
      handle_response connection.get(path, params)
    end

    # handles the response from the api and raises error if any
    # returns the response if no error
    # Error codes: https://currencylayer.com/documentation
    # error.code: 101, error.message: "You have not supplied an API Access Key. [Required format: access_key=YOUR_ACCESS_KEY]"
    def handle_response(response)
      return response if response.body["success"] == true

      raise Error.new(response.body["error"]["info"], response.body["error"]["code"])
    end
  end
end
# rubocop:enable Layout/LineLength
