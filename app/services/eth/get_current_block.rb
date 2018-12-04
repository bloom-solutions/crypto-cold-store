module Eth
  class GetCurrentBlock

    extend LightService::Action
    expects :ethereum_client
    promises :current_block_number

    executed do |c|
      response = GethCircuit.run_on_context(c) do
        c.ethereum_client.eth_block_number
      end

      c.current_block_number = response["result"].to_i(16)
    end

  end
end
