class InitMoneroClient

  extend LightService::Action
  promises :monero_client

  executed do |c|
    RPC.config.host = ENV["XMR_HOST"]
    RPC.config.port = ENV["XMR_PORT"]
    RPC.config.username = ENV["XMR_USERNAME"]
    RPC.config.password = ENV["XMR_PASSWORD"]
    RPC.config.transfer_clazz = ENV["XMR_TRANSFER_CLAZZ"]
    c.monero_client = RPC
  end

end
