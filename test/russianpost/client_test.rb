require "test_helper"
require "russianpost/client"

class TestClient < Minitest::Unit::TestCase
  def setup
    @client = RussianPost::Client.new
  end

  def test_returns_array_of_hashes
    VCR.use_cassette("valid_barcode") do
      response = @client.call(barcode: "RD025500807SE")
      assert_kind_of Array, response
      assert_kind_of Hash, response[0]
    end
  end

  def test_returns_nil_on_nonexistent_parcel
    VCR.use_cassette("nonexistent_parcel") do
      response = @client.call(barcode: "RR123456789EE")
      assert_nil response
    end
  end
end
