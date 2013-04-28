require "test_helper"
require "russianpost/parcel"

class ParcelTest < MiniTest::Unit::TestCase
  def test_returns_array_of_operations
    VCR.use_cassette :valid_barcode do
      parcel = RussianPost::Parcel.new("RD025500807SE")
      assert_kind_of Array, parcel.operations
      assert_kind_of RussianPost::Operation, parcel.operations[0]
    end
  end

  def test_returns_empty_array_on_nonexistent_parcel
    VCR.use_cassette("nonexistent_parcel") do
      parcel = RussianPost::Parcel.new("RR123456785EE")
      assert_kind_of Array, parcel.operations
      assert parcel.operations.empty?
    end
  end

  def test_raises_error_on_invalid_barcode
    assert_raises RussianPost::InvalidBarcode do
      RussianPost::Parcel.new("123")
    end
  end
end

class ParcelMetaTest < MiniTest::Unit::TestCase
  attr_reader :parcel

  def setup
    VCR.use_cassette :valid_barcode do
      @parcel = RussianPost::Parcel.new("RD025500807SE")
      parcel.operations
    end
  end  

  def test_knows_current_location
    location = RussianPost::Address.new("127576", "Москва 576")
    assert_equal location, parcel.location
  end

  def test_knows_parcel_mass
    assert_equal 281, parcel.mass
  end

  def test_knows_type
    type = RussianPost::GenericOperationParameter.new(5, "Мелкий пакет")
    assert_equal type, parcel.type
  end

  def test_knows_rank
    rank = RussianPost::GenericOperationParameter.new(5, "Без разряда")
    assert_equal rank, parcel.rank
  end
end
