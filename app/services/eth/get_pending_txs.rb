module Eth
  class GetPendingTxs

    extend LightService::Action
    expects :ethereum_client
    promises :remote_txs

    executed do |c|
      c.remote_txs = geth_circuit.run do
        c.ethereum_client.txpool_content["result"]["pending"].
          values.map(&:values).flatten
      end

      c.fail_and_return! "Unable to fetch txpool content" if c.remote_txs.nil?
    end

    def self.geth_circuit
      Circuitbox.circuit(:geth_circuit, {
        exceptions: [EOFError, Net::ReadTimeout],
      })
    end

  end
end
