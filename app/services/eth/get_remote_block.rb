module Eth
  class GetRemoteBlock

    extend LightService::Action
    expects :block_height, :ethereum_client
    promises :remote_block

    executed do |c|
      response = GethCircuit.run_on_context(c) do
        c.ethereum_client.eth_get_block_by_number(c.block_height, true)
      end

      c.remote_block = response["result"]
    end

  end
end
