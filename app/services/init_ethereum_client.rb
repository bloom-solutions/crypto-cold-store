class InitEthereumClient

  extend LightService::Action
  promises :ethereum_client

  executed do |c|
    c.ethereum_client = Ethereum::HttpClient.new(ENV["ETHEREUM_HOST"])
  end

end
