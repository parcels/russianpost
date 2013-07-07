require "russianpost/client"
require "russianpost/operations_factory"
require "russianpost/barcode"

module RussianPost
  class Parcel
    attr_reader :barcode, :client

    def initialize(barcode, opts = {})
      @barcode = Barcode.new(barcode)
      @client  = (opts[:client] || Client).instance
    end

    def operations
      @operations ||= fetch_operations
    end

    def location
      operations.last.operation_address unless operations.empty?
    end

    def mass
      operations.map{ |o| o.mass }.max
    end

    def rank
      operations.map{ |o| o.mail_rank }.compact.last
    end

    def recipient
      operations.map{ |o| o.rcpn }.compact.last
    end

    def type
      operations.last.mail_type unless operations.empty?
    end

    private

    def fetch_operations
      raise InvalidBarcode unless barcode.valid?
      OperationsFactory.build(client.call(barcode: barcode))
    end
  end

  class InvalidBarcode < ArgumentError; end
end
