module Btc
  class GetRemoteTxsFromTxIds

    extend LightService::Action
    expects :bitcoiner_client, :tx_ids
    promises :remote_txs
    VERBOSE = true

    executed do |c|
      args = c.tx_ids.map { |tx_id| ["getrawtransaction", [tx_id, VERBOSE]] }

      response = BitcoindCircuit.run_on_context(c) do
        c.bitcoiner_client.request(args)
      end

      c.remote_txs = response.map { |r| r["result"] }.compact
    end

  end
end
