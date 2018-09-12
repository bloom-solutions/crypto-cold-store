class InitBitcoinerClient

  extend LightService::Action
  promises :bitcoiner_client

  executed do |c|
    c.bitcoiner_client = Bitcoiner.new(
      ENV["BITCOIND_USERNAME"],
      ENV["BITCOIND_PASSWORD"],
      ENV["BITCOIND_HOST"],
    )
  end

end
