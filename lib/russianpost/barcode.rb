require "forwardable"
require "russianpost/barcode_validator"

module RussianPost
  class Barcode
    extend Forwardable

    def_delegator :barcode, :=~

    attr_reader :barcode

    def initialize(barcode)
      @barcode = barcode.strip.upcase
    end

    def to_s
      barcode
    end

    def valid?
      BarcodeValidator.validate(self)
    end
  end
end
