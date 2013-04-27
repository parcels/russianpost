module RussianPost
  class BarcodeValidator
    attr_reader :barcode

    INTERNATIONAL_FORMAT = /\A([A-Z]{2}\d{9}[A-Z]{2})\Z/
    DOMESTIC_FORMAT      = /\A(\d{14})\Z/
    WEIGHT_FACTORS       = [8, 6, 4, 2, 3, 5, 9, 7]

    def self.validate(barcode)
      new(barcode).valid?
    end

    def initialize(barcode)
      @barcode = barcode
    end

    def valid?
      (barcode =~ INTERNATIONAL_FORMAT && checkdigit_matches?) ||
        barcode =~ DOMESTIC_FORMAT
    end


    private
    
    def checkdigit_matches?
      barcode_digits.last == checksum
    end

    def barcode_digits
      barcode[/\d+/].split("").map(&:to_i)
    end
    
    def checksum
      product = barcode_digits[0..-2].zip(WEIGHT_FACTORS).map{|i, j| i * j}.inject(:+)
      mod = (11 - product) % 11
    end

    def checkdigit
      if (1..9).include? checksum
        checksum
      else 
        checksum == 10 ? 0 : 5
      end
    end
  end
end
