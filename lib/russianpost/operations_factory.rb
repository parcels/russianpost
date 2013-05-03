require "iso3166_ru"
require "russianpost/operation"
require "russianpost/country_factory"

module RussianPost
  module OperationsFactory
    class << self
      def build(operations_hash)
        @country_list = Iso3166Ru::CountryList.new
        operations_hash.map { |o| build_operation(o) }
      end

      def build_operation(operation_hash)
        operation = RussianPost::Operation.new
        ungroup_parameters(operation_hash).each do |key, value|
          operation[key] = process_param(key, value)
        end

        operation
      end


      private

      # Initially all parameters are grouped (address parameters, finance
      # parameters, etc.). This method flattens the structure a bit      
      def ungroup_parameters(operation_hash)
        operation_hash.values.compact.reduce(Hash.new){ |acc, el| acc.merge(el) }
      end

      # Methods below convert certain parameters into proper data structures
      def process_param(key, value)
        process_fixnum(key, value) ||
        process_address(key, value) ||
        process_country(key, value) ||
        process_generic_param(key, value) ||
        value
      end

      def process_fixnum(key, value)
        if [:payment, :value, :mass_rate, :insr_rate, :air_rate, :rate, :mass, :max_mass_ru, :max_mass_en].include? key
          value.to_i
        end
      end

      def process_address(key, value)
        if [:destination_address, :operation_address].include? key
          RussianPost::Address.new(
            value[:index],
            value[:description])
        end
      end

      def process_country(key, value)
        if [:mail_direct, :country_from, :country_oper].include? key
          RussianPost::CountryFactory.build(value, country_list: @country_list)
        end
      end

      def process_generic_param(key, value)
        if value.kind_of? Hash
          RussianPost::GenericOperationParameter.new(
            value[:id] ? value[:id].to_i : nil,
            value[:name])
        end
      end
    end
  end
end
