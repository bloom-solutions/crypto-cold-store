module Btc
  class GetRawMempoolTxIds

    extend LightService::Action
    expects :bitcoiner_client
    promises :tx_ids
    VERBOSE = false

    executed do |c|
      c.tx_ids = BitcoindCircuit.run_on_context(c) do
        c.bitcoiner_client.request("getrawmempool", VERBOSE)
      end
    end

  end
end
