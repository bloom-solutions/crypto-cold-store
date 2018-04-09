module Btc
  class GetBlocksToSync

    MAX_CONFS = 10
    extend LightService::Action
    expects :current_block_number
    promises :blocks_to_sync

    executed do |c|
      blocks = Block.btc
      insufficiently_confirmed_blocks = blocks.btc.with_confirmations_less_than(MAX_CONFS).
        order(height: :asc)

      if block = blocks.with_confirmations_less_than(MAX_CONFS).order(height: :asc).first
        c.blocks_to_sync = Array(block.height..c.current_block_number)
      elsif block = blocks.order(height: :asc).last
        c.blocks_to_sync = (block.height..c.current_block_number).to_a
      else
        c.blocks_to_sync = Array(c.current_block_number)
      end
    end

  end
end
