require "test_helper"
require "russianpost/barcode"

module RussianPost
  class BarcodeTest < Minitest::Test
    def test_implicitly_converts_to_string
      barcode = Barcode.new("RD025500807SE")
      assert_equal "bar RD025500807SE", "bar #{barcode}"
    end

    def test_validates_barcode
      ["123", "RR123456789EE"].each do |barcode|
        refute Barcode.new(barcode).valid?
      end

      ["RD025500807SE", "62009147017544"].each do |barcode|
        assert Barcode.new(barcode).valid?
      end
    end
  end
end
