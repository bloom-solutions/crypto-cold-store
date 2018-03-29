class InitElectrumClient

  extend LightService::Action
  promises :electrum_client

  executed do |c|
    host = Addressable::URI.heuristic_parse(ENV["ELECTRUM_HOST"])
    host.user = ENV["ELECTRUM_RPC_USER"]
    host.password = ENV["ELECTRUM_RPC_PASSWORD"]
    c.electrum_client = ElectrumRpcJsonClient.new(host: host.to_s)
  end

end
