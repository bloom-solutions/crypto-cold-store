module Btc
  class GetRemoteBlock

    extend LightService::Action
    expects :bitcoiner_client, :block_hash
    promises :remote_block
    VERBOSITY = 2

    executed do |c|
      c.remote_block = c.bitcoiner_client.
        request("getblock", c.block_hash, VERBOSITY)
    end

  end
end
