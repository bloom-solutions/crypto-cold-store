module Eth
  class GetPendingTxs

    extend LightService::Action
    expects :ethereum_client
    promises :remote_txs

    executed do |c|
      response = GethCircuit.run_on_context(c) do
        c.ethereum_client.txpool_content
      end

      c.remote_txs = response["result"]["pending"].values.map(&:values).flatten
    end

  end
end
