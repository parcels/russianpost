module RussianPost
  class Barcode
    attr_reader :barcode

    def initialize(barcode)
      @barcode = barcode
      raise InvalidBarcode unless valid?
    end

    def valid?
      barcode =~ /\A([A-Z]{2}\d{9}[A-Z]{2})|(\d{14})\z/
    end

    def to_s
      barcode
    end

    def to_str
      to_s
    end
  end

  class InvalidBarcode < ArgumentError; end
end
