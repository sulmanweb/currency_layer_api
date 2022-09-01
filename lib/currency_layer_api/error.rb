# frozen_string_literal: true

module CurrencyLayerApi
  # Error class for CurrencyLayerApi
  class Error < StandardError
    attr_reader :code

    def initialize(msg, exception_type)
      @code = exception_type
      super(msg)
    end
  end
end
