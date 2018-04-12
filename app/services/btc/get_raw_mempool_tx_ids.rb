module Btc
  class GetRawMempoolTxIds

    extend LightService::Action
    expects :bitcoiner_client
    promises :tx_ids
    VERBOSE = false

    executed do |c|
      c.tx_ids = c.bitcoiner_client.request("getrawmempool", VERBOSE)
    end

  end
end
