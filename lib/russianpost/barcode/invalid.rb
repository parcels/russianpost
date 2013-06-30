require 'russianpost/barcode/base'

module RussianPost
  module Barcode
    class Invalid < Base
      def valid?
        false
      end
    end
  end
end
