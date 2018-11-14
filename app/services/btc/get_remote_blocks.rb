module Btc
  class GetRemoteBlocks

    extend LightService::Action
    expects :bitcoiner_client, :block_hashes
    promises :remote_blocks
    VERBOSITY = 2

    executed do |c|
      args = c.block_hashes.map do |block_hash|
        ["getblock", [block_hash, VERBOSITY]]
      end

      response = c.bitcoiner_client.request(args)

      c.remote_blocks = response.map { |hash| hash["result"] }
    end

  end
end
