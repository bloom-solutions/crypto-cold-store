module Btc
  class GetRemoteBlocks

    extend LightService::Action
    expects :bitcoiner_client, :block_hashes
    promises :remote_blocks
    VERBOSITY = 2
    SLICE = 10.freeze

    executed do |c|
      args = c.block_hashes.map do |block_hash|
        ["getblock", [block_hash, VERBOSITY]]
      end

      c.remote_blocks = []

      args.each_slice(SLICE) do |a|
        response = c.bitcoiner_client.request(a)
        c.remote_blocks += response.map { |hash| hash["result"] }
      end
    end

  end
end
