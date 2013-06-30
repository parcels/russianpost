require 'russianpost/barcode/base'

module RussianPost
  module Barcode
    class International < Base
      WEIGHT_FACTORS = [8, 6, 4, 2, 3, 5, 9, 7, 0]

      def self.format
        /\A([A-Z]{2}\d{9}[A-Z]{2})\Z/
      end

      private

      def checkdigit
        checksum < 11 ? checksum % 10 : 5
      end

      def checksum
        11 - (digits.zip(WEIGHT_FACTORS).map{|i| i.reduce(:*)}.reduce(:+) % 11)
      end
    end
  end
end
