require "savon"

module RussianPost
  class Client
    attr_reader :savon, :endpoint, :namespace

    ENDPOINT  = "http://voh.russianpost.ru:8080/niips-operationhistory-web/OperationHistory"
    NAMESPACE = "http://russianpost.org/operationhistory/data"
    
    def initialize
      @savon = Savon.client(endpoint: ENDPOINT, namespace: NAMESPACE, log: false)
    end

    def call(opts = {barcode: nil})
      message = { "wsdl:Barcode" => opts[:barcode], "wsdl:MessageType" => "0" }
      response = savon.call("OperationHistoryRequest", message: message)

      response.to_hash[:operation_history_data][:history_record]
    end
  end
end
