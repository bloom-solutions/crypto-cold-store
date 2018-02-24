class InitElectrumClient

  extend LightService::Action
  promises :electrum_client

  executed do |c|
    c.electrum_client = ElectrumRpcJsonClient.new(host: ENV["ELECTRUM_HOST"])
  end

end
