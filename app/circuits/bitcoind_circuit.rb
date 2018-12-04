class BitcoindCircuit < ApplicationCircuit

  EXCEPTIONS = [
    Bitcoiner::Client::JSONRPCError,
    PG::ConnectionBad,
  ].freeze

  def self.call
    Circuitbox.circuit(:bitcoind_circuit, exceptions: EXCEPTIONS)
  end

end
