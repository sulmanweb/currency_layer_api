# frozen_string_literal: true

module CurrencyApi
  # Error class for CurrencyApi
  class Error < StandardError
    attr_reader :code

    def initialize(msg, exception_type)
      @code = exception_type
      super(msg)
    end
  end
end
