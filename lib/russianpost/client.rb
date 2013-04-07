require "savon"

module RussianPost
  class Client
    attr_reader :savon, :endpoint, :namespace
    
    def initialize
      @endpoint  = "http://voh.russianpost.ru:8080/niips-operationhistory-web/OperationHistory"
      @namespace = "http://russianpost.org/operationhistory/data"
      @savon     = Savon.client(endpoint: endpoint, namespace: namespace)
    end

    def get_operations_for(barcode)
      message = { "wsdl:Barcode" => barcode, "wsdl:MessageType" => "0" }
      savon.call("OperationHistoryRequest", message: message).to_hash
    end
  end
end
