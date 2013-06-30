require "forwardable"

module RussianPost
  module Barcode
    class Base
      extend Forwardable

      def_delegator :barcode, :=~

      attr_reader :barcode, :digits

      def self.format
        /.*/
      end

      def initialize(barcode)
        @barcode = barcode.strip.upcase
        @digits  = barcode.scan(/\d/).map { |d| d.to_i }
      end

      def valid?
        barcode =~ self.class.format && digits.last == checkdigit
      end

      def to_s
        barcode
      end
    end
  end
end
