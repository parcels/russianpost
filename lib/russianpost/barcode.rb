require "forwardable"
require "russianpost/barcode_validator"

module RussianPost
  class Barcode
    extend Forwardable

    def_delegator :barcode, :=~

    attr_reader :barcode

    def initialize(barcode)
      @barcode = barcode.strip.upcase
      raise InvalidBarcode unless valid?
    end

    def to_s
      barcode
    end

    def digits
      barcode[/\d+/].split("").map { |d| d.to_i }
    end

    private

    def valid?
      BarcodeValidator.validate(self)
    end
  end

  class InvalidBarcode < ArgumentError; end
end
