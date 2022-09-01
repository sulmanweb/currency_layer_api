# frozen_string_literal: true

require_relative "currency_layer_api/version"
require "faraday"

# :nodoc:
module CurrencyLayerApi
  autoload :Client, "currency_layer_api/client"
  autoload :Error, "currency_layer_api/error"
  autoload :Currency, "currency_layer_api/currency"
  autoload :Conversion, "currency_layer_api/conversion"
end
