class GethCircuit < ApplicationCircuit

  EXCEPTIONS = [
    EOFError,
    Net::ReadTimeout,
    Errno::EHOSTUNREACH,
    PG::ConnectionBad,
  ].freeze

  def self.call
    Circuitbox.circuit(:geth_circuit, exceptions: EXCEPTIONS)
  end

end
