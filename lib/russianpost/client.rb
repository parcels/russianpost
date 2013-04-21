require "savon"

module RussianPost
  class Client
    attr_reader :savon, :endpoint, :namespace
    
    def initialize
      @endpoint  = "http://voh.russianpost.ru:8080/niips-operationhistory-web/OperationHistory"
      @namespace = "http://russianpost.org/operationhistory/data"
      @savon     = Savon.client(endpoint: endpoint, namespace: namespace, log: false)
    end

    def call(barcode: nil)
      message = { "wsdl:Barcode" => barcode, "wsdl:MessageType" => "0" }
      response = savon.call("OperationHistoryRequest", message: message)

      response.to_hash[:operation_history_data][:history_record]
    end
  end
end
