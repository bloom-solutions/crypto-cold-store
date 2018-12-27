module Eth
  class CheckConfirmations

    extend LightService::Action
    expects :blocks, :block_height

    executed do |c|
      block = c.blocks.find_by(height: c.block_height)
      next c if block.nil? || block.confirmations < GetBlocksToSync::MAX_CONFS
      c.skip_remaining!
    end

  end
end
