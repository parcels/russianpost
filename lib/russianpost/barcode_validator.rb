module RussianPost
  class BarcodeValidator
    attr_reader :barcode, :digits

    INTERNATIONAL_FORMAT = /\A([A-Z]{2}\d{9}[A-Z]{2})\Z/
    DOMESTIC_FORMAT      = /\A(\d{14})\Z/
    WEIGHT_FACTORS       = [8, 6, 4, 2, 3, 5, 9, 7, 0]

    def self.validate(barcode)
      new(barcode).valid?
    end

    def initialize(barcode)
      @barcode = barcode
      @digits  = barcode.digits
    end

    def valid?
      valid_international? || valid_domestic?
    end


    private

    def valid_international?
      barcode =~ INTERNATIONAL_FORMAT && digits.last == checkdigit
    end

    def valid_domestic?
      barcode =~ DOMESTIC_FORMAT
    end

    def checkdigit
      if (1..9).include? checksum
        checksum
      else 
        checksum == 10 ? 0 : 5
      end
    end
    
    def checksum
      product = digits.zip(WEIGHT_FACTORS)
      (11 - product.map{|i| i.reduce(:*)}.reduce(:+)) % 11
    end
  end
end
