module Btc
  class GetRemoteTxsFromTxIds

    extend LightService::Action
    expects :bitcoiner_client, :tx_ids
    promises :remote_txs
    VERBOSE = true

    executed do |c|
      args = c.tx_ids.map { |tx_id| ["getrawtransaction", [tx_id, VERBOSE]] }

      response = bitcoind_circuit.run do
        c.bitcoiner_client.request(args)
      end

      if response.nil?
        c.fail_and_return!("bitcoind call failed or circuit open")
      end

      c.remote_txs = response.map { |r| r["result"] }.compact
    end

    def self.bitcoind_circuit
      Circuitbox.circuit(:bitcoind, {
        exceptions: [Bitcoiner::Client::JSONRPCError],
      })
    end

  end
end
