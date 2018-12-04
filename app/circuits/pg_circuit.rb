class PgCircuit < ApplicationCircuit

  EXCEPTIONS = [
    PG::ConnectionBad,
  ].freeze

  def self.call
    Circuitbox.circuit(:pg_circuit, exceptions: EXCEPTIONS)
  end

end
