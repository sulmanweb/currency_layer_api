# frozen_string_literal: true

module CurrencyLayerApi
  # Currency Class for CurrencyLayerApi
  class Currency
    attr_reader :code, :name

    def initialize(code:, name:)
      @code = code
      @name = name
    end
  end
end
