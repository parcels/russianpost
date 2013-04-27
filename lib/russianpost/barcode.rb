require "russianpost/barcode_validator"

module RussianPost
  class Barcode
    attr_reader :barcode

    def initialize(barcode)
      @barcode = barcode.strip.upcase
      raise InvalidBarcode unless valid?
    end

    def to_s
      barcode
    end

    private

    def valid?
      BarcodeValidator.validate(barcode)
    end
  end

  class InvalidBarcode < ArgumentError; end
end
