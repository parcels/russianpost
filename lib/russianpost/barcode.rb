module RussianPost
  class Barcode
    attr_reader :barcode

    def initialize(barcode)
      @barcode = barcode
    end

    def to_s
      barcode
    end

    def to_str
      to_s
    end
  end
end
