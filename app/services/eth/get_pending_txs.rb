module Eth
  class GetPendingTxs

    extend LightService::Action
    expects :ethereum_client
    promises :remote_txs

    executed do |c|
      c.remote_txs = c.ethereum_client.
        txpool_content["result"]["pending"].
        values.map(&:values).flatten
    end

  end
end
