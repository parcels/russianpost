require "russianpost/client"
require "russianpost/operations_factory"

module RussianPost
  class Parcel
    attr_reader :barcode, :client

    def initialize(barcode, opts = {})
      @barcode = Barcode.new(barcode.upcase)
      @client  = (opts[:client] || Client).new
    end

    def operations
      @operations ||= fetch_operations
    end

    private

    def fetch_operations
      OperationsFactory.build(client.call(barcode: barcode))
    end
  end
end
