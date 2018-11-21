module Btc
  class GetRemoteBlocks

    extend LightService::Action
    expects :bitcoiner_client, :block_hashes
    promises :remote_blocks
    VERBOSITY = 2.freeze

    executed do |c|
      args = c.block_hashes.map do |block_hash|
        ["getblock", [block_hash, VERBOSITY]]
      end

      response = bitcoind_circuit.run do
        c.bitcoiner_client.request(args)
      end

      if response.nil?
        c.fail_and_return!("bitcoind call failed or circuit open")
      end

      c.remote_blocks = response.map { |hash| hash["result"] }
    end

    def self.bitcoind_circuit
      Circuitbox.circuit(:bitcoind, {
        exceptions: [Bitcoiner::Client::JSONRPCError],
      })
    end

  end
end
