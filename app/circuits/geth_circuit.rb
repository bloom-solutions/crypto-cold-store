class GethCircuit < ApplicationCircuit

  EXCEPTIONS = [
    EOFError,
    Net::ReadTimeout,
    Errno::EHOSTUNREACH,
    SocketError,
  ].freeze

  def self.call
    Circuitbox.circuit(:geth_circuit, exceptions: EXCEPTIONS)
  end

end
