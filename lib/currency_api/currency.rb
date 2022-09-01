# frozen_string_literal: true

module CurrencyApi
  # Currency Class for CurrencyApi
  class Currency
    attr_reader :code, :name

    def initialize(code:, name:)
      @code = code
      @name = name
    end
  end
end
