module RussianPost
  Operation = Struct.new(
    # address parameters
    :destination_address,   # Address
    :operation_address,     # Address
    :mail_direct,           # Country
    :country_from,          # Country
    :country_oper,          # Country

    # finance parameters
    :payment,               # Fixnum
    :value,                 # Fixnum
    :mass_rate,             # Fixnum
    :insr_rate,             # Fixnum
    :air_rate,              # Fixnum
    :rate,                  # Fixnum

    # item parameters
    :barcode,               # String
    :internum,              # String
    :valid_ru_type,         # Boolean
    :valid_en_type,         # Boolean
    :complex_item_name,     # String
    :mail_rank,             # GenericOperationParameter
    :post_mark,             # GenericOperationParameter
    :mail_type,             # GenericOperationParameter
    :mail_ctg,              # GenericOperationParameter
    :mass,                  # Fixnum
    :max_mass_ru,           # Fixnum
    :max_mass_en,           # Fixnum

    # operation parameters
    :oper_type,             # GenericOperationParameter
    :oper_attr,             # GenericOperationParameter
    :oper_date,             # DateTime

    # user parameters
    :send_ctg,              # GenericOperationParameter
    :sndr,                  # String
    :rcpn)                  # String

  Country = Struct.new(
    :id,                    # Fixnum
    :code_2a,               # String
    :code_3a,               # String
    :name_ru,               # String
    :name_en)               # String

  GenericOperationParameter = Struct.new(
    :id,                    # Fixnum
    :name)                  # String

  Address = Struct.new(
    :index,                 # String
    :description)           # String
end
