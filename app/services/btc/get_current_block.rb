module Btc
  class GetCurrentBlock

    extend LightService::Action
    expects :bitcoiner_client
    promises :current_block_number, :current_block_hash

    executed do |c|
      c.current_block_number = c.bitcoiner_client.request("getblockcount")
      c.current_block_hash = GetBlockHash.of_height(
        c.current_block_number,
        bitcoiner_client: c.bitcoiner_client,
      )
    end

  end
end
