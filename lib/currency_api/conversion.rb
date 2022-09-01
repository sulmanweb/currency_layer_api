# frozen_string_literal: true

module CurrencyApi
  # Conversion Class for CurrencyApi
  class Conversion
    attr_reader :from_code, :to_code, :value, :date

    def initialize(from_code:, to_code:, value:, date: nil)
      @from_code = from_code
      @to_code = to_code
      @value = value
      @date = date
    end
  end
end
