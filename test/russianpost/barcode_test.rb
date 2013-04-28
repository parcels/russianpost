require "test_helper"
require "russianpost/barcode"

class BarcodeTest < MiniTest::Unit::TestCase
  def test_implicitly_converts_to_string
    barcode = RussianPost::Barcode.new("RD025500807SE")
    assert_equal "bar RD025500807SE", "bar #{barcode}"
  end

  def test_raises_on_invalid_barcode
    ["123", "RR123456789EE"].each do |barcode|
      assert_raises RussianPost::InvalidBarcode do
        RussianPost::Barcode.new(barcode)
      end
    end
  end

  def test_doesnt_raise_on_valid_barcode
    ["RD025500807SE", "12345678901234"].each do |barcode|
        RussianPost::Barcode.new(barcode)
    end
  end
end
