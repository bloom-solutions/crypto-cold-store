module Eth
  class GetRemoteBlock

    extend LightService::Action
    expects :block_height, :ethereum_client
    promises :remote_block

    executed do |c|
      c.remote_block = c.ethereum_client.
        eth_get_block_by_number(c.block_height, true)["result"]
    end

  end
end
