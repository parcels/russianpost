require "russianpost/client"
require "russianpost/operations_factory"
require "russianpost/barcode"

module RussianPost
  class Parcel
    attr_reader :barcode, :client

    def initialize(barcode, opts = {})
      @barcode = Barcode.new(barcode)
      @client  = (opts[:client] || Client).new
    end

    def operations
      @operations ||= fetch_operations
    end

    def location
      operations.last.operation_address
    end

    def mass
      operations.map(&:mass).max
    end

    def rank
      operations.map(&:mail_rank).compact.last
    end

    def type
      operations.last.mail_type
    end

    private

    def fetch_operations
      OperationsFactory.build(client.call(barcode: barcode))
    end
  end
end
