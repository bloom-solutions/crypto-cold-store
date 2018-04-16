module Eth
  class SaveBlockInfo

    extend LightService::Action
    expects :remote_block, :current_block_number
    promises :block

    executed do |c|
      remote_block = c.remote_block
      block = Block.eth.where(block_hash: remote_block["hash"]).
        first_or_initialize

      height = remote_block["number"].to_i(16)
      confirmations = c.current_block_number - height + 1

      block.update_attributes!(
        height: height,
        confirmations: confirmations,
      )
      c.block = block
    end

  end
end
