require "test_helper"
require "russianpost/barcode"

class BarcodeTest < MiniTest::Unit::TestCase
  def test_implicitly_converts_to_string
    barcode = RussianPost::Barcode.new("RD025500807SE")
    assert_equal "bar RD025500807SE", "bar #{barcode}"
  end
end
