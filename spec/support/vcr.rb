require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  [
    "ETHEREUM_HOST",
    "BITCOIND_HOST",
    "BITCOIND_USERNAME",
    "BITCOIND_PASSWORD",
  ].each do |var|
    config.filter_sensitive_data("[#{var}]") { ENV[var] }
  end
end
