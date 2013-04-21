require "russianpost/client"
require "russianpost/operations_factory"

module RussianPost
  class Parcel
    attr_reader :barcode, :client

    def initialize(barcode, client: Client)
      @barcode = barcode.upcase
      @client  = client.new

      raise InvalidBarcode unless barcode_is_valid?
    end

    def operations
      @operations ||= fetch_operations
    end

    private

    def fetch_operations
      OperationsFactory.build(client.call(barcode: barcode))
    end

    def barcode_is_valid?
      barcode =~ /\A([A-Z]{2}\d{9}[A-Z]{2})|(\d{14})\z/
    end
  end

  class InvalidBarcode < ArgumentError; end
end
