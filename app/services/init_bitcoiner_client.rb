class InitBitcoinerClient

  extend LightService::Action
  promises :bitcoiner_client

  executed do |c|
    c.bitcoiner_client = Bitcoiner.new(
      ENV["BITCOIND_RPC_USER"],
      ENV["BITCOIND_RPC_PASSWORD"],
      ENV["BITCOIND_HOST"],
    )
  end

end
