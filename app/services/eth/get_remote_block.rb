module Eth
  class GetRemoteBlock

    extend LightService::Action
    expects :block_index, :ethereum_client
    promises :remote_block

    executed do |c|
      c.remote_block = c.ethereum_client.
        eth_get_block_by_number(c.block_index, true)["result"]
    end

  end
end
