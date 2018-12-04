class GethCircuit < ApplicationCircuit

  EXCEPTIONS = [
    EOFError,
    Errno::ECONNREFUSED,
    Errno::EHOSTUNREACH,
    Net::OpenTimeout,
    Net::ReadTimeout,
    SocketError,
  ].freeze

  def self.call
    Circuitbox.circuit(:geth_circuit, exceptions: EXCEPTIONS)
  end

end
