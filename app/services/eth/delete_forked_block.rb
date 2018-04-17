module Eth
  class DeleteForkedBlock

    extend LightService::Action
    expects :remote_block

    executed do |c|
      height = c.remote_block["number"].to_i(16)
      block_hash = c.remote_block["hash"]
      forked_blocks = Block.eth.where(height: height).
        where.not(block_hash: block_hash)
      forked_blocks.destroy_all
    end

  end
end
