module Btc
  class AppendOutputAddress

    extend LightService::Action
    expects :output_addresses, :remote_tx_output_addresses

    executed do |c|
      c.output_addresses += c.remote_tx_output_addresses
    end

  end
end
