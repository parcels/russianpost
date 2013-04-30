require "savon"

module RussianPost
  class Client
    attr_reader :savon, :endpoint, :namespace

    ENDPOINT  = "http://voh.russianpost.ru:8080/niips-operationhistory-web/OperationHistory"
    NAMESPACE = "http://russianpost.org/operationhistory/data"
    
    def initialize(opts = {})
      @savon = Savon.client(
        endpoint:     ENDPOINT,
        namespace:    NAMESPACE,
        open_timeout: opts[:timeout] || 10, # in seconds
        log:          false)
    end

    def call(opts = {barcode: nil})
      message = { "wsdl:Barcode" => opts[:barcode], "wsdl:MessageType" => "0" }
      response = savon.call("OperationHistoryRequest", message: message)
      result = response.to_hash[:operation_history_data][:history_record]

      result.kind_of?(Array) ? result : [result].compact
    end
  end
end
