# frozen_string_literal: true

require "test_helper"

# :nodoc:
class ClientTest < Minitest::Test
  def test_access_key
    client = CurrencyApi::Client.new access_key: "test"
    assert_equal "test", client.access_key
  end

  def test_list
    stub = stub_request("list", response: stub_response(fixture: "list"))
    client = CurrencyApi::Client.new(access_key: "fake", adapter: :test, stubs: stub)
    currency_list = client.list

    assert_equal CurrencyApi::Currency, currency_list.first.class
    assert_equal "AED", currency_list.first.code
  end

  def test_live
    stub = stub_request("live", response: stub_response(fixture: "live"))
    client = CurrencyApi::Client.new(access_key: "fake", adapter: :test, stubs: stub)
    conversion_list = client.live

    assert_equal CurrencyApi::Conversion, conversion_list.first.class
    assert_equal "USD", conversion_list.first.from_code
    assert_equal "AUD", conversion_list.first.to_code
  end

  def test_historical
    stub = stub_request("historical", response: stub_response(fixture: "historical"))
    client = CurrencyApi::Client.new(access_key: "fake", adapter: :test, stubs: stub)
    conversion_list = client.historical(date: "2005-02-01")

    assert_equal CurrencyApi::Conversion, conversion_list.first.class
    assert_equal "USD", conversion_list.first.from_code
    assert_equal "AED", conversion_list.first.to_code
    assert_equal "2005-02-01", conversion_list.first.date
  end

  def test_convert
    stub = stub_request("convert", response: stub_response(fixture: "convert"))
    client = CurrencyApi::Client.new(access_key: "fake", adapter: :test, stubs: stub)
    conversion = client.convert(to: "GBP", from: "USD", amount: 1)

    assert_equal 6.58443, conversion
  end

  def test_error
    stub = stub_request("list", response: stub_response(fixture: "error"))
    client = CurrencyApi::Client.new(access_key: "fake", adapter: :test, stubs: stub)

    error = assert_raises(CurrencyApi::Error) { client.list }

    assert_equal 104, error.code
  end
end
