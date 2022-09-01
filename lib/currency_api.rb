# frozen_string_literal: true

require_relative "currency_api/version"
require "faraday"

# :nodoc:
module CurrencyApi
  autoload :Client, "currency_api/client"
  autoload :Error, "currency_api/error"
  autoload :Currency, "currency_api/currency"
  autoload :Conversion, "currency_api/conversion"
end
