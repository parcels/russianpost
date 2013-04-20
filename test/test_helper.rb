require "minitest/autorun"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  # c.allow_http_connections_when_no_cassette = true
end
