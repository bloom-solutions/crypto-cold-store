module Btc
  class SaveBlockInfo

    extend LightService::Action
    expects :remote_block
    promises :block

    executed do |c|
      remote_block = c.remote_block
      block = Block.btc.where(block_hash: remote_block["hash"]).
        first_or_initialize
      block.update_attributes(
        height: remote_block["height"],
        confirmations: remote_block["confirmations"],
      )
      c.block = block
    end

  end
end
