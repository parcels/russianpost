require 'russianpost/barcode/base'
require 'iso3166_ru'

module RussianPost
  module Barcode
    class International < Base
      WEIGHT_FACTORS = [8, 6, 4, 2, 3, 5, 9, 7, 0]

      def self.format
        /\A([A-Z]{2}\d{9}[A-Z]{2})\Z/
      end

      def valid?
        super && country_exists?
      end

      private

      def country_exists?
        !Iso3166Ru.find_by(alpha2: barcode[-2..-1]).nil?
      end

      def checkdigit
        checksum < 11 ? checksum % 10 : 5
      end

      def checksum
        11 - (digits.zip(WEIGHT_FACTORS).map{|i| i.reduce(:*)}.reduce(:+) % 11)
      end
    end
  end
end
