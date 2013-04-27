module RussianPost
  class Barcode
    attr_reader :barcode

    WEIGHT_FACTORS = [8, 6, 4, 2, 3, 5, 9, 7]

    def initialize(barcode)
      @barcode = barcode.strip.upcase
      raise InvalidBarcode unless valid?
    end

    def to_s
      barcode
    end

    def to_str
      to_s
    end

    private

    def valid?
      barcode =~ /\A([A-Z]{2}\d{9}[A-Z]{2})|(\d{14})\z/ && checkdigit_matches?
    end
    
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

  class InvalidBarcode < ArgumentError; end
end
