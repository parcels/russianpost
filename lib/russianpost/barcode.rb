require 'russianpost/barcode/international'
require 'russianpost/barcode/domestic'
require 'russianpost/barcode/invalid'

module RussianPost
  module Barcode
    def self.new(barcode)
      [International, Domestic, Invalid].each do |klass|
        return klass.new(barcode) if barcode =~ klass.format
      end
    end
  end
end
