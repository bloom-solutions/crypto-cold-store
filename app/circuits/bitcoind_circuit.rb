class BitcoindCircuit < ApplicationCircuit

  EXCEPTIONS = [
    Bitcoiner::Client::JSONRPCError,
  ].freeze

  def self.call
    Circuitbox.circuit(:bitcoind_circuit, exceptions: EXCEPTIONS)
  end

end
