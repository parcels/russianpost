require 'russianpost/barcode/base'

module RussianPost
  module Barcode
    class Domestic < Base
      def self.format
        /\A\d{14}\Z/
      end

      private

      def checkdigit
        odds, evens = *digits.partition.with_index { |d, i| (i&1).zero? }
        (10 - ((odds.reduce(:+) * 3 + evens[0..-2].reduce(:+)) % 10)) % 10
      end
    end
  end
end
