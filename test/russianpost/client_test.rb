require 'test_helper'
require 'russianpost/client'

class TestClient < Minitest::Test
  def setup
    @client = RussianPost::Client.instance
  end

  def test_returns_array_of_hashes_on_existing_parcel
    ['RD025500807SE', 'LK035658376US'].each do |code|
      VCR.use_cassette(code) do
        response = @client.call(barcode: code)
        assert_kind_of Array, response
        assert_kind_of Hash, response[0]
      end
    end
  end

  def test_returns_empty_array_on_nonexistent_parcel
    VCR.use_cassette('RR123456789EE') do
      response = @client.call(barcode: 'RR123456789EE')
      assert_kind_of Array, response
      assert_empty response
    end
  end
end
